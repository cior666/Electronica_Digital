module antirrebote(
    input wire clk,
    input wire reset,
    input wire senal_entrada,  // Señal del pulsador con rebotes
    output reg salida_limpia   // Señal limpia, sin rebotes
);
    reg [19:0] contador;       // Contador para estabilizar la señal
    reg salida_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            contador <= 20'b0;
            salida_reg <= 1'b0;
            salida_limpia <= 1'b0;
        end else begin
            if (senal_entrada != salida_reg) begin
                contador <= 20'b0; // Reinicia el contador si hay un cambio en la señal
                salida_reg <= senal_entrada;
            end else if (contador < 20'd999) begin
                contador <= contador + 1; // Incrementa el contador
            end else begin
                salida_limpia <= salida_reg; // Estabiliza la señal después de alcanzar el límite
            end
        end
    end
endmodule