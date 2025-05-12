//parte fija
`default_nettype none
`define VCD_OUTPUT "1_tb.vcd"
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module and_comp ();
    // Entradas
    reg A;
    reg B;
    // Salida
    wire X;

    // Instancia del modulo AND
AND_compuerta UUT (
    .A(A),
    .B(B),
    .X(X)
);

initial begin
    //parte fija
    $dumpfile("1_tb.vcd"); 
    $dumpvars(0, and_comp); 
    #10 A = 1; B = 0; #10;
    #10 A = 0; B = 1; #10;
    #10 A = 1; B = 1; #10;
    #10 A = 0; B = 0; #10;
    $finish;
end
endmodule