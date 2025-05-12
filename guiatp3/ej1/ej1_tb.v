//parte fija
`default_nettype none
`define VCD_OUTPUT "ej1_tb.vcd"
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module decimal_to_bcd_tb();
reg [9:0] D; // Entradas decimales
wire [3:0] BCD; // Salida BCD

    // Instancia del módulo
decimal_to_bcd UUT (
    .D(D),
    .BCD(BCD)
);

initial begin
    //parte fija
    $dumpfile("ej1_tb.vcd"); 
    $dumpvars(0, decimal_to_bcd_tb); 
    D= 10'b0000000000; #10;
    for (integer i = 0; i < 10; i = i + 1) begin
        D = 10'b1 << i; #10;
        $display("D = %b -> BCD = %b", D, BCD);
    end

    $finish;
end
endmodule
