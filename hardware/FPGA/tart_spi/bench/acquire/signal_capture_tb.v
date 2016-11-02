`timescale 1ns/100ps
/*
 * Module      : bench/signal_capture_tb.v
 * Copyright   : (C) Tim Molteno     2016
 *             : (C) Max Scheel      2016
 *             : (C) Patrick Suggate 2016
 * License     : LGPL3
 * 
 * Maintainer  : Patrick Suggate <patrick.suggate@gmail.com>
 * Stability   : Experimental
 * Portability : simulation file, and only tested with Icarus Verilog
 * 
 * Testbench for testing TART's signal-capturing circuitry.
 * 
 * NOTE:
 * 
 * TODO:
 * 
 */

module signal_capture_tb;


   reg clk12x = 1, clk = 1, rst = 0;
   reg ce = 0, r = 0, x = 0;
   wire d, q, ready, locked, invalid;

   wire p = r ^ d;

   always #2.5 clk12x <= ~clk12x;
   always #30 clk <= ~clk;


   initial begin : SIGNAL_TB
      $dumpfile ("signal_tb.vcd");
      $dumpvars;
      
      #45 rst = 1; #90 rst = 0;

      #720;
      #720;
      #720;
      #720 $finish;
   end


   always @(posedge clk)
     x <= $random;

   always @(negedge clk)
     r <= x;

   always @(posedge clk)
     ce <= !rst ? 1 : 0 ;


   signal_capture SIGCAP0
     ( .clk(clk12x),
       .rst(rst),
       .ce(ce),
       .d(d),
       .q(q),
       .ready(ready),
       .locked(locked),
       .invalid(invalid)
       );

   signal_stagger
     #( .PHASE_JITTER(2),
        .PHASE_OFFSET(2),
        .CYCLE_JITTER(0)
        ) STAGGER0
       (
        .clk(clk12x),
        .rst(rst),
        .ce (ce),
        .d  (x),
        .q  (d)
        );

   
endmodule // signal_capture_tb
