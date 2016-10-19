`timescale 1ns/100ps
/*
 * Module      : verilog/bus/wb_get_block.v
 * Copyright   : (C) Tim Molteno     2016
 *             : (C) Max Scheel      2016
 *             : (C) Patrick Suggate 2016
 * License     : LGPL3
 * 
 * Maintainer  : Patrick Suggate <patrick.suggate@gmail.com>
 * Stability   : Experimental
 * Portability : only tested with Icarus Verilog
 * 
 * Generates the control and address signals needed, to prefetch a block of
 * data, using Wishbone-like burst transfers.
 * 
 * NOTE:
 * 
 * Changelog:
 *  + 20/08/2016  --  initial file;
 * 
 * TODO:
 * 
 */

module wb_get_block
  #(parameter BSIZE = 24,
    parameter BBITS = 5,
    parameter BSB   = BBITS-1,
    parameter DELAY = 3)
   (
    input          clk_i,
    input          rst_i,
    output reg     cyc_o = 0,
    output reg     stb_o = 0,
    output         we_o,
    output reg     bst_o = 0,
    input          ack_i,
    input          wat_i,
    output [BSB:0] blk_o,

    input          read_i,
    output reg     done_o = 0
    );

   wire            cyc = stb_o || wat > 1 || !ack_i;
   wire            stb = bst_o;
   wire            bst = blk < BSIZE-2;
   reg [BSB:0]     blk = 0;
   reg [2:0]       wat = 0; // # of outstanding requests

   wire [BBITS:0]  blk_nxt = blk + 1;

   assign we_o  = 0;
   assign blk_o = blk;


   //-------------------------------------------------------------------------
   //  Fetch-port state and bus-control signals.
   //-------------------------------------------------------------------------
   always @(posedge clk_i)
     if (rst_i)
       {cyc_o, stb_o, bst_o} <= #DELAY 3'b000;
     else if (read_i)
       {cyc_o, stb_o, bst_o} <= #DELAY 3'b111;
     else if (cyc_o)
       {cyc_o, stb_o, bst_o} <= #DELAY {cyc, stb, bst};
     else
       {cyc_o, stb_o, bst_o} <= #DELAY 3'b000;

   //-------------------------------------------------------------------------
   //  Address generation, with a block.
   always @(posedge clk_i)
     if (rst_i || read_i)               blk <= #DELAY 0;
     else if (cyc_o && bst_o && !wat_i) blk <= #DELAY blk_nxt;

   //-------------------------------------------------------------------------
   //  Count to make sure that all requested data is retransmitted.
   always @(posedge clk_i)
     if (rst_i)   wat <= #DELAY 0;
     else if (cyc_o)
       case ({stb_o, ack_i})
         2'b10:   wat <= #DELAY wat + 1;
         2'b01:   wat <= #DELAY wat - 1;
         default: wat <= #DELAY wat;
       endcase // case ({stb_o, ack_i})


   //-------------------------------------------------------------------------
   //  Strobe the `done_o` signal when a prefetch has been completed.
   //-------------------------------------------------------------------------
   always @(posedge clk_i)
     if (rst_i || read_i) done_o <= #DELAY 0;
     else                 done_o <= #DELAY cyc_o && !cyc;


endmodule // wb_get_block