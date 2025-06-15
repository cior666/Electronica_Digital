module mealy_1011(
    input wire clk,      // Señal de reloj
    input wire rst,      // Reset asíncrono activo en alto
    input wire din,      // Entrada de datos serial (renombrada)
    output reg out       // Salida: 1 cuando detecta la secuencia 1011
);
    // Definición de los estados de la máquina (usando localparam para compatibilidad Verilog)
localparam [2:0]
    S0= 3'b000,
    S1= 3'b001,
    S2= 3'b010,
    S3= 3'b011;
reg [2:0] state, nextstate;
    // Registro de estado: avanza al siguiente estado en cada flanco de reloj o vuelve a S0 si hay reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;         // Si hay reset, vuelve al estado inicial
        else
            state <= nextstate; // Si no, avanza al siguiente estado
    end

    // Lógica de transición de estados y salida
    always @(*) begin
        nextstate = state; // Por defecto, el siguiente estado es el actual 
        case (state)
            S0: begin // Estado inicial, espera el primer '1'
                if (din) 
                nextstate = S1;
                else    
                nextstate = S0;
            end
            S1: begin // Detectó '1', espera un '0'
                if (!din) 
                nextstate = S2;
                else     
                nextstate = S1;
            end
            S2: begin // Detectó '10', espera un '1'
                if (din) 
                nextstate = S3;
                else    
                nextstate = S0;
            end
            S3: begin // Detectó '101', espera el último '1'
                if (din) begin
                    nextstate = S0; // Secuencia completa, vuelve a S0 (no solapamiento)
                    out = 1'b1;      // Activa la salida: detectó '1011'
                end else begin
                    nextstate = S2; // Si recibe '0', vuelve a S2
                    out=0;
                end
            end
        endcase
    end

endmodule


//RESOLUCION AGUS
/* module secuencia2 (
    input wire clk,
    input wire reset,
    input wire w,
    output reg z
)

localparam [2:0]
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011;

reg [2:0] state, nextstate;

always@(posedge clk, posedge reset)
begin
    if(reset)
      begin
        state<=S0;
      end
    else
       begin
        state<=nextstate;
       end
end

always @*
begin
    nextstate=state;
    case(state)
    S0: if(w==0)
          nextstate=S0;
        else
          nextstate=S1;
    S1: if(w==0)
          nextstate=S2;
        else
          nextstate=S0;
    S2: if(w==0)
          nextstate=S0;
        else
          nextstate=S3;
    S3: if(w==0)
          nextstate=S0;
          z=1
        else
          nextstate=S0;
            z=0;
    default:
          nextstate=state;
    endcase
end

endmodule
*/ 
