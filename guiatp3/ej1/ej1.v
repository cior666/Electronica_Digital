module decimal_to_bcd (
    input  [9:0] D,         // Entradas decimales (10 bits)
    output reg [3:0] BCD    // Salida BCD (4 bits)
);


always @(*) begin
    case (D)
        10'b0000000001: BCD = 4'd0;
        10'b0000000010: BCD = 4'd1;
        10'b0000000100: BCD = 4'd2;
        10'b0000001000: BCD = 4'd3;
        10'b0000010000: BCD = 4'd4;
        10'b0000100000: BCD = 4'd5;
        10'b0001000000: BCD = 4'd6;
        10'b0010000000: BCD = 4'd7;
        10'b0100000000: BCD = 4'd8;
        10'b1000000000: BCD = 4'd9; // 10 en decimal
        default: BCD = 4'bxxxx; // Error: más de una entrada activa o ninguna
    endcase
end

endmodule

