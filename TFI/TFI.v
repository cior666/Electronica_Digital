// ========================
// Módulo antirrebote simple
module antirrebote(
    input wire clk,
    input wire rst,
    input wire btn_in,
    output reg btn_out
);
    reg [6:0] cnt;
    reg btn_sync;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            btn_sync <= 0;
            btn_out <= 0;
        end else begin
            btn_sync <= btn_in;
            if (btn_sync == btn_in)
                cnt <= cnt + 1;
            else
                cnt <= 0;
            if (cnt == 16'hFFFF)
                btn_out <= btn_in;
        end
    end
endmodule

// ========================================
// FSM para detectar ingreso y egreso de autos
// ========================================
module fsm_estacionamiento(
    input wire clk,
    input wire rst,
    input wire a,
    input wire b,
    output reg ingreso,
    output reg egreso
);
    localparam S0 = 3'd0, // ambos libres
               S1 = 3'd1, // solo a bloqueado
               S2 = 3'd2, // ambos bloqueados
               S3 = 3'd3; // solo b bloqueado

    reg [2:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        ingreso = 0;
        egreso = 0;
        case (state)
            S0: begin
                if (a && !b) next_state = S1;
                else if (!a && b) next_state = S3;
            end
            S1: begin
                if (a && b) next_state = S2;
                else if (!a && !b) next_state = S0;
            end
            S2: begin
                if (!a && b) next_state = S3;
                else if (a && !b) next_state = S1;
            end
            S3: begin
                if (!a && !b) begin
                    next_state = S0;
                    ingreso = 1; // Detecta ingreso
                end else if (a && b) next_state = S2;
            end
        endcase

        // Egreso: secuencia inversa
        if (state == S0 && !a && b) next_state = S3;
        if (state == S3 && a && b) next_state = S2;
        if (state == S2 && a && !b) next_state = S1;
        if (state == S1 && !a && !b) begin
            next_state = S0;
            egreso = 1; // Detecta egreso
        end
    end
endmodule

// ========================================
// Contador ascendente/descendente de 0 a 7
module contador_vehiculos(
    input wire clk,
    input wire rst,
    input wire inc, // pulso de ingreso
    input wire dec, // pulso de egreso
    output reg [2:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 3'd0;
        else begin
            case ({inc, dec})
                2'b10: if (count < 7) count <= count + 1; // solo ingreso
                2'b01: if (count > 0) count <= count - 1; // solo egreso
                default: count <= count; // sin cambio o ambos activos
            endcase
        end
    end
endmodule

// ========================================
// Top module: integra todo el sistema
// ========================================
module TFI(
    input wire clk,
    input wire rst,
    input wire btn_a, // Pulsador simula sensor a
    input wire btn_b, // Pulsador simula sensor b
    output reg [3:0] leds // Visualización del contador en los 4 LEDs
);

    // Señales internas
    wire a, b;
    wire ingreso, egreso;
    wire [2:0] count;

    // Antirrebote para cada pulsador
    antirrebote deb_a(
        .clk(clk),
        .rst(rst),
        .btn_in(btn_a),
        .btn_out(a)
    );
    antirrebote deb_b(
        .clk(clk),
        .rst(rst),
        .btn_in(btn_b),
        .btn_out(b)
    );

    // FSM de detección de ingreso/egreso
    fsm_estacionamiento fsm(
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .ingreso(ingreso),
        .egreso(egreso)
    );

    // Contador de vehículos
    contador_vehiculos contador(
        .clk(clk),
        .rst(rst),
        .inc(ingreso),
        .dec(egreso),
        .count(count)
    );

    // Señal de cupo completo
    wire full;
    assign full = (count == 3'd7);

    // Visualización en LEDs usando reg y always
    always @(posedge clk or posedge rst) begin
        if (rst)
            leds <= 4'b0000;
        else
            leds <= {full, count};
    end

endmodule