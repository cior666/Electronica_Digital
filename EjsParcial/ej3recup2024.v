//Diseñar e implementar un codificador de ocho lineas (e1...e8) 
// a binario (s4...s1) con prioridad en las entradas.

module 8line_to_bcd(
    input reg [7:0] e,
    output reg [3:0] s
);

always (*) begin
    case (e)
        8'b00000001: s = 4'b0000; // e1
        8'b00000010: s = 4'b0001; // e2
        8'b00000100: s = 4'b0010; // e3
        8'b00001000: s = 4'b0011; // e4
        8'b00010000: s = 4'b0100; // e5
        8'b00100000: s = 4'b0101; // e6
        8'b01000000: s = 4'b0110; // e7
        8'b10000000: s = 4'b0111; // e8
        default: s = 4'b1111; // Ninguna entrada activa
    endcase
end