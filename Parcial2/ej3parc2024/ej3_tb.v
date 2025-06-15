`timescale 1ns / 1ps
`default_nettype none

module ej3_tb;
    reg clk, rst, din;
    wire out;

    // Instancia del DUT
    mealy_1011 uut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .out(out)
    );

    // Generador de reloj
    initial clk = 0;
    always #5 clk = ~clk; // Periodo de 10

    initial begin
        $dumpfile("ej3_tb.vcd");
        $dumpvars(0, ej3_tb);

        // Inicialización
        rst = 1; din = 0;
        #12 rst = 0;

        // Prueba: secuencia 1 0 1 1 (debe detectar)
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;

        // Prueba: secuencia 1 0 1 0 1 1 (debe detectar solo una vez, sin solapamiento)
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;

        // Prueba: secuencia incorrecta
        din = 0; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #10;

        // Prueba: dos secuencias separadas
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;
        din = 1; #10;
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;

        $finish;
    end
endmodule
