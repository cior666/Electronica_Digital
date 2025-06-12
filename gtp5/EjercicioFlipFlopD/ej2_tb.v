`timescale 1ns / 1ps
`default_nettype none

module ej2_tb;
    reg D, clk, rst; // Entradas deben ser reg
    wire Q;          // Salida debe ser wire

    // Instancia del DUT
    flip_flop_D uut (
        .D(D),
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    initial begin
        $dumpfile("ej2_tb.vcd");
        $dumpvars(0, ej2_tb);

        // Inicialización
        clk = 0; rst = 1; D = 0;
        #5 rst = 0;

        // Prueba: recorrer D=0 y D=1 varias veces usando un for
        integer i;
        for (i = 0; i < 4; i = i + 1) begin
            D = i % 2;
            #10;
        end

        // Prueba reset
        #10 rst = 1;
        #5 rst = 0;
        #10;

        $finish;
    end

    always #5 clk = ~clk; // Reloj de periodo 10

endmodule
