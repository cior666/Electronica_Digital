//CONTADOR
module contar_autos(
    input wire clk,
    input wire reset,
    input wire entrada,
    input wire salida,
    output reg [6:0] espacio
);

always @(posedge clk or posedge reset) begin
    if(reset)
    count<=7'b0; //reiniciamos a 0
    else begin
        if(entrada and !salida and espacio<7) //sumamos por entrada
        espacio<=espacio+1;
        else if(salida and !entrada and espacio>0) //restamos por salida
        espacio<=espacio-1;
    end
end
endmodule
