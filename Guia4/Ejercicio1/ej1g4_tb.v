`timescale 1ns / 1ps
`default_nettype none

module ej1g4_tb();
    reg A, B, Cin, Bin;
    reg [2:0] Op;
    wire Result, Cout, Bout, Z, P;

    // Instancia de la ALU
alu_1bit UUT (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Bin(Bin),
    .Op(Op),
    .Result(Result),
    .Cout(Cout),
    .Bout(Bout),
    .Z(Z),
    .P(P)
);

initial begin
    $dumpfile("ej1g4_tb.vcd");
    $dumpvars(0, ej1g4_tb);

    // Pruebas para cada operación
    A = 1; B = 0; Cin = 0; Bin = 0; Op = 3'b001; #10; // Suma
    A = 1; B = 1; Cin = 0; Bin = 0; Op = 3'b010; #10; // Resta
    A = 1; B = 0; Cin = 0; Bin = 0; Op = 3'b100; #10; // Suma lógica
    A = 1; B = 1; Cin = 0; Bin = 0; Op = 3'b101; #10; // Producto lógico
    A = 1; B = 0; Cin = 0; Bin = 0; Op = 3'b110; #10; // Complemento
    A = 0; B = 0; Cin = 0; Bin = 0; Op = 3'b000; #10; // No operación

    $finish;
end
endmodule
