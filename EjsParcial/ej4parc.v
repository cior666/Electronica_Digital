module convertBCD_to_7seg(
    input wire [3:0] bcd,         // Entrada de 4 bits en BCD (0 a 9)
    output reg [7:0] seg          // Salida de 8 bits para el display 7 segmentos [A,B,C,D,E,F,G,DP]
);
    always @(*) begin
        case (bcd)
            4'd0: seg = 8'b11111100; // 0  -> Enciende segmentos A,B,C,D,E,F (apaga G y DP)
            4'd1: seg = 8'b01100000; // 1  -> Enciende segmentos B,C
            4'd2: seg = 8'b11011010; // 2  -> Enciende segmentos A,B,D,E,G
            4'd3: seg = 8'b11110010; // 3  -> Enciende segmentos A,B,C,D,G
            4'd4: seg = 8'b01100110; // 4  -> Enciende segmentos B,C,F,G
            4'd5: seg = 8'b10110110; // 5  -> Enciende segmentos A,C,D,F,G
            4'd6: seg = 8'b10111110; // 6  -> Enciende segmentos A,C,D,E,F,G
            4'd7: seg = 8'b11100000; // 7  -> Enciende segmentos A,B,C
            4'd8: seg = 8'b11111110; // 8  -> Enciende todos los segmentos menos DP
            4'd9: seg = 8'b11110110; // 9  -> Enciende segmentos A,B,C,D,F,G
            default: seg = 8'b00000000; // Apaga todos los segmentos (incluido DP)
        endcase
    end
endmodule