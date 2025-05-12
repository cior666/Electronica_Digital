module bcd_to_decimal(
    input [3:0] BCD,
    output reg [9:0] D // Salida decimal (10 bits)  
);

always @(*) begin
    case (BCD)
        4'b0000: D = 10'b0000000001; // 0 
        4'b0001: D = 10'b0000000010; // 1 
        4'b0010: D = 10'b0000000100; // 2 
        4'b0011: D = 10'b0000001000; // 3 
        4'b0100: D = 10'b0000010000; // 4 
        4'b0101: D = 10'b0000100000; // 5 
        4'b0110: D = 10'b0001000000; // 6 
        4'b0111: D = 10'b0010000000; // 7 
        4'b1000: D = 10'b0100000000; // 8 
        4'b1001: D = 10'b1000000000; // 9 
        default: D = 10'bxxxxxxxxxx; 
    endcase
end
endmodule