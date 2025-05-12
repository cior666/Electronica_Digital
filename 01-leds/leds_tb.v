//-------------------------------------------------------------------
//-- leds_tb.v
//-- Testbench
//-------------------------------------------------------------------
//-- Juan Gonzalez (Obijuan)
//-- Jesus Arroyo Torrens
//-- GPL license
//-------------------------------------------------------------------
`default_nettype none
//`define VCD_OUTPUT "leds_output"
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module leds_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

//-- Leds port
wire l0, l1, l2, l3;

//botones 
reg[3:0] BTN;

//-- Instantiate the unit to test
leds UUT (
           .LED0(l0),
           .LED1(l1),
           .LED2(l2),
           .LED3(l3),
           .BTN(BTN)
         );


initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, leds_tb);

  BTN=4'b0000;
  #10 BTN = 4'b0001; // Presionar el botón 0
  #10 BTN = 4'b0010; // Presionar el botón 1
  #10 BTN = 4'b0100; // Presionar el botón 2
  #10 BTN = 4'b1000; // Presionar el botón 3
  #10 BTN = 4'b1111; // Presionar todos los botones
  #10 BTN = 4'b0000; // Soltar todos los botones

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule
