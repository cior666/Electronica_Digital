module FFT(
    input wire T,clk,rst
    output reg Q
);

//ASINCRONICO
always (@posedge clk or posedge rst) begin
    if(rst)
    Q<=0; //cuando rst=1, Q pasa a valer 0
    else if(T)
    Q<=~Q;  //Si T=1, cambia (toggle)
    //Si T=0, mantiene su valor automaticamente
end


//SINCRONO
always(@posedge clk) begin
    if(rst)
    Q<=0; //este rst esta sincronizado con los pulsos de reloj
    else if (T)
    Q<=~Q; //Toggle cuando T=1
    //Si T=0 => Q no cambia
end
endmodule

//always(@posedge clk)
// Ejecuta este bloque solo cuando reloj cambia de 0 a 1
//usamos solo clock cuando queremos que las acciones ocurran una sola vez por ciclo de reloj, no en todo momento en que el reloj esta en 1
//usar posdege nos asegura que el codigo no se repite mientras el reloj esta en alto yq se ejecuta solo en el instante
// de cambio de 0 a 1.
