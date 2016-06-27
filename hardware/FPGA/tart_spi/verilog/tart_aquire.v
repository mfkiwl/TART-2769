`timescale 1ns/100ps
/*
 * 
 * TART's data-aquisition control subcircuit, connected via a Wishbone-like
 * interconnect.
 * 
 * Has system registers for:
 *   000  --  antenna data stream;
 *   001  --  antenna data[23:16];
 *   010  --  antenna data[15: 8];
 *   011  --  antenna data[ 7: 0];
 *   101  --  aquisition sample delay;
 *   110  --  aquisition debug mode; and
 *   111  --  aquisition status and control.
 * 
 * NOTE:
 *  + supports both classic and pipelined transfers;
 * 
 * TODO:
 * 
 */

// Support CLASSIC Wishbone-like bus transactions?
`define __WB_CLASSIC
// `undef __WB_CLASSIC


//----------------------------------------------------------------------------
//  TART DATA-AQUISITION UNIT REGISTERS
//----------------------------------------------------------------------------
// Raw antenna-data, read-back registers:
`define AX_STREAM 0
`define AX_DATA1  1
`define AX_DATA2  2
`define AX_DATA3  3

// Visibilities access, status, and control:
`define VX_STREAM 4
`define VX_STATUS 5

// Data-aquisition status, and control:
`define AQ_DEBUG  6
`define AQ_STATUS 7


module tart_aquire
  #(parameter WIDTH = 8,        // WB-like bus data-width
    parameter MSB   = WIDTH-1,
    parameter ACCUM = 32,       // #bits of the viz accumulators
    parameter DELAY = 3)
   (
    // Wishbone-like bus interface:
    input              clk_i,
    input              rst_i,
    input              cyc_i,
    input              stb_i,
    input              we_i,
    output reg         ack_o = 0,
    input [2:0]        adr_i,
    input [MSB:0]      dat_i,
    output reg [MSB:0] dat_o = 0,

    // Streaming data interface:
    // NOTE: Doesn't need to initiate transfers, but data is valid whenever
    //   `data_ready` is asserted.
    input              data_ready,
    output             data_request,
    input [23:0]       data_in,

    // SPI status flags:
    input              spi_busy,

    // Visibilities status-flags, and settings:
    output             vx_cyc_o, // Wishbone-like (master) bus interface,
    output             vx_stb_o, // for reading back visibilities
    output             vx_we_o,
    input              vx_ack_i,
    input [MSB:0]      vx_dat_i,
    input              available,
    input              accessed,
    output [ACCUM-1:0] blocksize,

    output reg         aq_debug_mode = 0,
    output reg         aq_enabled = 0,
	  output reg [2:0]   aq_sample_delay = 0
    );


   //-------------------------------------------------------------------------
   //  Local wires.
   wire [MSB:0]        ax_stream;
   wire [23:0]         ax_data;

   reg [4:0]           log_block = 0; // = log2(#viz/block);
   reg [ACCUM-1:0]     blocksize = 0; // = #viz/block - 1;
   wire [MSB:0]        vx_status = {available, accessed, 1'b0, log_block};

   wire [MSB:0]        aq_debug  = {aq_debug_mode, 4'b0, aq_sample_delay};
   wire [MSB:0]        aq_status = {{MSB{1'b0}}, aq_enabled};


   //-------------------------------------------------------------------------
   //  Wishbone-like (slave) bus interface logic.
   //-------------------------------------------------------------------------
   //  Generate acknowledges for incoming requests.
   always @(posedge clk_i)
     if (rst_i)
       ack_o <= #DELAY 1'b0;
     else if (cyc_i && stb_i && !ack_o)
       case (adr_i)
         `VX_STREAM: ack_o <= #DELAY vx_ack_i;
         default:    ack_o <= #DELAY 1'b1;
       endcase // case (adr_i)
     else
       ack_o <= #DELAY 1'b0;

   //-------------------------------------------------------------------------
   //  Read back the appropriate register.
   always @(posedge clk_i)
`ifdef __WB_CLASSIC
     if (cyc_i && stb_i && !we_i && !ack_o)
`else
     if (cyc_i && stb_i && !we_i)
`endif
       case (adr_i)
         //  Antenna-data access registers:
         `AX_STREAM: dat_o <= #DELAY ax_stream;
         `AX_DATA1:  dat_o <= #DELAY ax_data[23:16];
         `AX_DATA2:  dat_o <= #DELAY ax_data[15: 8];
         `AX_DATA3:  dat_o <= #DELAY ax_data[ 7: 0];

         //  Visibilities registers:
         `VX_STREAM: dat_o <= #DELAY vx_dat_i;
         `VX_STATUS: dat_o <= #DELAY vx_status;

         //  Aquisition status, and control, registers:
         `AQ_DEBUG:  dat_o <= #DELAY aq_debug;
         `AQ_STATUS: dat_o <= #DELAY aq_status;

         default:    dat_o <= #DELAY 'bx;
       endcase // case (adr_i)

   //-------------------------------------------------------------------------
   //  Write into the appropriate register.
   always @(posedge clk_i)
     if (rst_i)
       {aq_enabled, aq_debug_mode, aq_sample_delay} <= #DELAY 0;
     else if (cyc_i && stb_i && we_i)
       case (adr_i)
         `VX_STATUS: log_block <= #DELAY dat_i[4:0];
         `AQ_DEBUG:  {aq_debug_mode, aq_sample_delay} <= #DELAY {dat_i[7], dat_i[2:0]};
         `AQ_STATUS: aq_enabled <= #DELAY dat_i[0];
       endcase // case (adr_i)


   //-------------------------------------------------------------------------
   //  Visibilities access and control circuit.
   //-------------------------------------------------------------------------
   wire                bs_new;

   assign bs_new   = cyc_i && stb_i && we_i && !ack_o && adr_i == `VX_STATUS;
   assign vx_cyc_o = cyc_i;
   assign vx_stb_o = stb_i && adr_i == `VX_STREAM;
   assign vx_we_o  = 1'b0;

   //  TODO: How slow is computing the new block-size?
   always @(posedge clk_i)
     if (bs_new)
       blocksize <= #DELAY (1 << dat_i[4:0]) - 1;


   //-------------------------------------------------------------------------
   //  DRAM prefetcher-control logic.
   //-------------------------------------------------------------------------
   wire [MSB:0]        data [0:2];
   reg                 data_sent = 0;
   reg [1:0]           index = 0;
   wire                send, wrap_index;
   wire [1:0]          next_index = wrap_index ? 0 : index + 1;

   assign data[0]    = ax_data[23:16];
   assign data[1]    = ax_data[15: 8];
   assign data[2]    = ax_data[ 7: 0];
   assign ax_stream  = data[index];

   assign send       = cyc_i && stb_i && !we_i && !ack_o && adr_i == `AX_STREAM;
   assign wrap_index = index == 2;

   //-------------------------------------------------------------------------
   //  Increment the current antenna-data index, and prefetch more data as
   //  needed.
   always @(posedge clk_i)
     if (rst_i) data_sent <= #DELAY 0;
     else       data_sent <= #DELAY wrap_index && send;

   always @(posedge clk_i)
     if (!spi_busy) index <= #DELAY 0;
     else if (send) index <= #DELAY next_index;


   //-------------------------------------------------------------------------
   //  DRAM prefetch logic core.
   //-------------------------------------------------------------------------
   dram_prefetch #( .WIDTH(24) ) DRAM_PREFETCH0
     ( .clk(clk_i),
       .rst(rst_i),
       .dram_ready(data_ready),
       .dram_request(data_request),
       .dram_data(data_in),
       .data_sent(data_sent),
       .fetched_data(ax_data)
       );


endmodule // tart_aquire
