//Detectamos señales de entradas de auto
/*
SECUENCIA ENTRADA (auto entrando):
inicio: A=0, B=0 → ENT1: A=1, B=0 → ENT2: A=1, B=1 → ENT3: A=0, B=1 → S0: A=0, B=0 (entrada=1)

SECUENCIA SALIDA (auto saliendo):
inicio: A=0, B=0 → SAL1: A=0, B=1 → SAL2: A=1, B=1 → SAL3: A=1, B=0 → S0: A=0, B=0 (salida=1)
*/
module detector(
    input wire clk,
    input botonA,
    input botonB,
    output reg entrada,
    output reg salida
);
// estados de la secuencia
localparam inicio = 3'b000;     
localparam ENT1 = 3'b001;     
localparam ENT2 = 3'b010;     
localparam ENT3 = 3'b011;     
localparam SAL1 = 3'b100;     
localparam SAL2 = 3'b101;     
localparam SAL3 = 3'b110;     

reg [2:0] state, nextstate;
initial begin
    state = inicio;
    nextstate = inicio;
end

always@(posedge clk)
begin 
    state <= nextstate;
end

always @* begin
    entrada = 0;//inicializo
    salida = 0; //inicializo
    nextstate = state; //inicializo
    case(state)
    //Entrada
    inicio: begin 
        if({botonA,botonB} == 2'b10)
            nextstate = ENT1; //entrada
        else if({botonA,botonB} == 2'b01)
            nextstate = SAL1; //salida
    end
    ENT1: begin 
        if({botonA,botonB} == 2'b11)
            nextstate = ENT2;//entrada
        else if({botonA,botonB} == 2'b00)
            nextstate = inicio; //se sueltan los botones
        else if({botonA,botonB} == 2'b01)
            nextstate = SAL1; //salida
    end
    ENT2: begin 
        if({botonA,botonB} == 2'b01)
            nextstate = ENT3;//entrada
        else if({botonA,botonB} == 2'b00)
            nextstate = inicio; //se sueltan los botones
        else if({botonA,botonB} == 2'b10)
            nextstate = SAL3; //salida
    end
    ENT3: begin 
        if({botonA,botonB} == 2'b00) begin
            nextstate = inicio;
            entrada = 1; // completa entrada
        end
        else if({botonA,botonB} == 2'b11)
            nextstate = SAL2; //salida
        else if({botonA,botonB} == 2'b10)
            nextstate = ENT1; //entrada
    end
    //Salida
    SAL1: begin 
        if({botonA,botonB} == 2'b11)
            nextstate = SAL2;
        else if({botonA,botonB} == 2'b00)
            nextstate = inicio; 
        else if({botonA,botonB} == 2'b10)
            nextstate = ENT1; 
    end
    SAL2: begin 
        if({botonA,botonB} == 2'b10)
            nextstate = SAL3;
        else if({botonA,botonB} == 2'b00)
            nextstate = inicio; 
        else if({botonA,botonB} == 2'b01)
            nextstate = ENT3; 
    end
    SAL3: begin 
        if({botonA,botonB} == 2'b00) begin
            nextstate = inicio;
            salida = 1; //salida completa
        end
        else if({botonA,botonB} == 2'b11)
            nextstate = ENT2;
        else if({botonA,botonB} == 2'b01)
            nextstate = SAL1; 
    end
    default: begin 
        nextstate = inicio; 
        entrada = 0; 
        salida = 0; 
    end
    endcase
end
endmodule
