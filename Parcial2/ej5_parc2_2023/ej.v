module caracol(
    input wire A,
    input wire clk,
    input wire reset,
    output wire y
);

localparam S0=2'b00;
localparam S1=2'b01;
localparam S2=2'b10;

reg [1:0] state, next_state; // Corrige el tamaño a 2 bits si tienes 3 estados

// Actualiza el estado en cada flanco de subida del reloj
always @(posedge clk or posedge reset) begin
    if(reset)
        state<=S0;
    else 
        state <= next_state;
end

// Lógica de transición de estados
always @(*) begin
    case (state)
        S0: if (A==0) 
                next_state = S1;
            else   
                next_state = S0;
        S1: if (A==1) 
                next_state = S2;
            else   
                next_state = S1;
        S2: if (A==0) 
                next_state = S1;
            else   
                next_state = S0;
        default: next_state = S0;
    endcase
end
// Lógica de salida (ejemplo: salida activa solo en S2)
assign y = (state == S2);
endmodule

