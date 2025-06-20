//Detectamos señales de entradadas de auto
/*
ENTRADA
S0: no se detectan pulsos
S1: detectamos boton A
S2:detectamos boton A y B
S3: detectamos boton B (sin A) 
S3->S0 Z=1

SALIDA
S3:detectamos boton B
S2: detectamos boton A y B
S1: detectamos boton A
S1->S0
S0: no se detectan pulsos (salio un auto) 
*/
module detector(
    input wire clk,
    input wire reset,
    input wire botonA,
    input wire botonB,
    output reg entrada,
    output reg salida
);

localparam S0=2'b00; //no detectamos pulsos
localparam S1=2'b10; // detectamos boton A
localparam S2=2'b11; //detectamos botones A y B
localparam S3=2'b01; //detectamos B

reg [1:0] state, nextstate;

always@(posedge clk or posedge reset)
begin 
    if(reset)
        state <= S0;
    else
        state <= nextstate;
end

always @* begin
    entrada = 0;
    salida = 0;
    nextstate = state;
    case(state)
    S0: begin
        if({botonA,botonB}==2'b10)
           nextstate = S1; // posible entrada
        else if({botonA,botonB}==2'b01)
            nextstate = S3; // posible salida
    end
    S1: begin
        if ({botonA,botonB}==2'b11)
            nextstate = S2; // posible entrada
        else if({botonA,botonB}==2'b00) begin
            nextstate = S0; // confirmamos salida
            salida = 1; // aumentamos contador
        end
    end
    S2: begin
        if({botonA,botonB}==2'b01)
            nextstate = S3;
        else if({botonA,botonB}==2'b10)
            nextstate = S1; // posible salida
    end
    S3: begin
        if({botonA,botonB}==2'b00) begin
            nextstate = S0; // entro un auto
            entrada = 1; // contamos
        end else if({botonA,botonB}==2'b11)
            nextstate = S2; // posible salida
    end
    default: begin nextstate = state; entrada = 0; salida = 0; end
    endcase
end
endmodule