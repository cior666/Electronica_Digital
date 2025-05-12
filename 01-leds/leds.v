//------------------------------------------------------------------
//-- Hello world example
//-- Turn on all the leds
//-- This example has been tested on the following boards:
//--   * Lattice icestick
//--   * Icezum alhambra (https://github.com/FPGAwars/icezum)
//------------------------------------------------------------------

module leds(output wire LED0,
            output wire LED1,
            output wire LED2,
            output wire LED3,
            input wire [3:0] BTN);




assign LED0 = ~BTN[0];
assign LED1 = ~BTN[0];
assign LED2 = ~BTN[0];
assign LED3 = ~BTN[0];

endmodule
