module suma (
    input wire A, B, Cin, // Entradas
    output wire S, Cout   // Salidas
);
// Lógica del sumador completo
assign S = A ^ B ^ Cin;          // Suma
assign Cout = (A & B) | (A & Cin) | (B & Cin); // Acarreo de salida
endmodule

module resta (
    input wire A, B, Bin, // Entradas
    output wire D, Bout   // Salidas
);
// Lógica del restador completo
assign D = A ^ B ^ Bin;          // Diferencia
assign Bout = (~A & B) | ((~A | B) & Bin); // Acarreo de salida
endmodule

module alu_1bit (
    input wire A, B, Cin, Bin, // Entradas
    input wire [2:0] Op,       // Código de operación
    output wire Result,        // Resultado
    output wire Cout, Bout, Z, P // Bandera de acarreo, cero y paridad
);
    wire S, D, OR_res, AND_res, NOT_res;

// Instancias de los módulos de suma y resta
suma sumador (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);

resta restador (
    .A(A),
    .B(B),
    .Bin(Bin),
    .D(D),
    .Bout(Bout)
);

// Operaciones lógicas
assign OR_res = A | B;  // Suma lógica
assign AND_res = A & B; // Producto lógico
assign NOT_res = ~A;    // Complemento

// Multiplexor para seleccionar la operación
assign Result = (Op == 3'b001) ? S :       // Suma
                (Op == 3'b010) ? D :       // Resta
                (Op == 3'b100) ? OR_res :  // Suma lógica
                (Op == 3'b101) ? AND_res : // Producto lógico
                (Op == 3'b110) ? NOT_res : // Complemento
                1'b0;                      // No operación

// Bandera de cero (Z) y paridad (P)
assign Z = (Result == 1'b0); // Bandera de cero
assign P = ~Result;          // Bandera de paridad (inversión del resultado)
endmodule