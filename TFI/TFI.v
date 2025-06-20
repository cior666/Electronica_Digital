module TFI(
    input wire clk,
    input wire reset,
    input wire botonA,
    input wire botonB,
    output wire [3:0] leds
);

wire botonA_estable, botonB_estable;
wire entrada, salida;
wire [6:0] espacio;

sensores sensores_instacia(
    .clk(clk),
    .reset(reset),
    .botonA(botonA),
    .botonB(botonB),
    .botonA_estable(botonA_estable),
    .botonB_estable(botonB_estable)
);

detector detector_instancia(
    .clk(clk),
    .reset(reset),
    .botonA(botonA_estable),
    .botonB(botonB_estable),
    .entrada(entrada),
    .salida(salida)
);

visualizacion leds_inst(
    .espacio(espacio),
    .leds(leds)
);

contar_autos contador_instancia(
    .clk(clk),
    .reset(reset),
    .entrada(entrada),
    .salida(salida),
    .espacio(espacio)
);

endmodule