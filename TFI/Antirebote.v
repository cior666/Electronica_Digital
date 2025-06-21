module antirrebote(
    input wire clk,
    input wire senal_entrada,  
    output reg salida_limpia   
);
    reg [19:0] contador;      
    reg salida_reg;

initial begin
    salida_limpia = 0;
    salida_reg = 0;
    contador = 0;
end

always @(posedge clk) begin
    if (senal_entrada != salida_reg) begin
        contador <= 20'b0; 
        salida_reg <= senal_entrada;
    end else if (contador < 20'd240000) begin
        contador <= contador + 1; 
    end else begin
        salida_limpia <= salida_reg;
    end
end
endmodule