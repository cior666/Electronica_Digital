module moore(
    input wire clk,      // Señal de reloj
    input wire reset,    // Reset asíncrono activo en alto
    input wire w,        // Entrada serial de datos
    output reg z      // Salida: 1 cuando detecta '00110'
);

    // 1. Definimos los estados de la máquina usando localparam para compatibilidad Verilog.
    //    Cada estado representa cuántos bits correctos de la secuencia llevamos detectados.
    localparam S0 = 3'b000; // Estado inicial, no se detectó nada
    localparam S1 = 3'b001; // Detectó '0'
    localparam S2 = 3'b010; // Detectó '00'
    localparam S3 = 3'b011; // Detectó '001'
    localparam S4 = 3'b100; // Detectó '0011'
    localparam S5 = 3'b101; // Detectó '00110' (salida activa)

    reg [2:0] state, next_state; // Registros para el estado actual y el siguiente

    // 2. Registro de estado: avanza al siguiente estado en cada flanco de reloj o vuelve a S0 si hay reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;         // Si hay reset, vuelve al estado inicial
        else
            state <= next_state; // Si no, avanza al siguiente estado
    end

    // 3. Lógica de transición de estados (cómo avanza la máquina según la entrada w)
    always @(*) begin
        case (state)
            S0: begin // Estado inicial, espera el primer '0'
                if (w == 0) next_state = S1;
                else        next_state = S0;
            end
            S1: begin // Detectó '0', espera otro '0'
                if (w == 0) next_state = S2;
                else        next_state = S0;
            end
            S2: begin // Detectó '00', espera un '1'
                if (w == 1) next_state = S3;
                else        next_state = S2; // Permite varios ceros seguidos
            end
            S3: begin // Detectó '001', espera otro '1'
                if (w == 1) next_state = S4;
                else        next_state = S0;
            end
            S4: begin // Detectó '0011', espera un '0'
                if (w == 0) next_state = S5; // Secuencia completa
                else        next_state = S0;
            end
            S5: begin // Detectó '00110', salida activa
                next_state = S0; // Sin solapamiento: vuelve a S0
            end
            default: next_state = S0;
        endcase
    end

    // 4. Lógica de salida Moore: la salida depende solo del estado actual
    always @(*) begin
        // Por defecto, la salida es 0
        z = 1'b0;
        // Solo en el estado S5 (secuencia completa) la salida es 1
        if (state == S5)
            z = 1'b1;
    end

endmodule

