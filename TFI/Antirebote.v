module antirrebote(
    input wire clk,
    input wire senal_entrada,  
    output reg salida_limpia   
);
    reg [3:0] contador;      
    reg senal_sync;

initial begin
    contador = 0;
    salida_limpia = 0;
    senal_sync = 0;
end
// Sincronización y antirebote
always @(posedge clk) begin
    senal_sync <= senal_entrada;  // Sincronizar entrada
    
    if (senal_sync == salida_limpia) begin
        contador <= 4'd0;  // Resetear contador si no hay cambio
    end else begin
        if (contador < 4'd5) begin
            contador <= contador + 1;
        end else begin
            salida_limpia <= senal_sync;  // Actualizar salida después de 5 ciclos
            contador <= 4'd0;
        end
    end
end
endmodule