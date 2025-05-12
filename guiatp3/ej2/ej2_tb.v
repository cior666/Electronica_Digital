//parte fija
`default_nettype none
`define VCD_OUTPUT "ej2_tb.vcd"
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module bcd_to_decimal_tb();
reg [3:0] BCD;
wire [9:0] D;

bcd_to_decimal UUT(
    .BCD(BCD),
    .D(D)
);

initial begin
    //parte fija
    $dumpfile("ej2_tb.vcd");
    $dumpvars(0, bcd_to_decimal_tb);
    for (integer i=0; i<10; i=i+1) begin
        BCD = i; #10;
    end
    $finish;
end
endmodule