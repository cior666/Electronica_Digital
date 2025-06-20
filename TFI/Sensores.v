//hacemos un modulo aparte para organizar mejor
module sensores(
    input wire clk,
    input wire reset,
    input wire botonA,
    input wire botonB,
    output wire botonA_estable,
    output wire botonB_estable
);

antirrebote antirreboteA(
    .clk(clk),
    .reset(reset),
    .senal_entrada(botonA),
    .salida_limpia(botonA_estable)
);

antirrebote antirreboteB(
    .clk(clk),
    .reset(reset),
    .senal_entrada(botonB),
    .salida_limpia(botonB_estable)
);

endmodule