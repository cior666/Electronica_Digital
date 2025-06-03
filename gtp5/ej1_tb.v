`timescale 1ns / 1ps
`default_nettype none

module ej1_tb;
    reg J, K, clk, rst;
    wire Q;

    flip_flop_jk uut (
        .J(J),
        .K(K),
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    initial begin
        $dumpfile("ej1_tb.vcd");
        $dumpvars(0, ej1_tb);

        clk = 0; rst = 1; J = 0; K = 0;
        #5 rst = 0;

        // Probar todas las combinaciones de J y K
        for (integer i = 0; i < 4; i = i + 1) begin
            {J, K} = i[1:0];
            #10;
        end

        // Probar toggle varias veces
        J = 1; K = 1;
        repeat (3) begin
            #10;
        end

        $finish;
    end

    always #5 clk = ~clk; // Reloj de periodo 10

endmodule
