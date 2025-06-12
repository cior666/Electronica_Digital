//flip flop D
module flip_flop_D(
    input wire D,
    input wire clk,
    input wire rst,   // instanciamos el rst porq garantiza que Q empiece en 0
    output reg Q
);
//FFD con reset asincrono
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= 0;
       end else begin
        Q <= D;
        end
    end
//@(posedge clk or posedge rst):
//El bloque se ejecuta en cada flanco de subida del reloj (clk) o cuando el reset (rst) pasa de 0 a 1.
//=============
//if (rst):
//Si el reset está activo (rst == 1), la salida Q se pone inmediatamente en 0, 
//sin esperar al reloj (reset asíncrono).
//================
//else Q <= D;:
//Si el reset no está activo, en el próximo flanco de subida del reloj, Q toma el valor de la entrada D.

endmodule
// FFD con reset sincrono
//
// always @(posedge clk) begin
//     if (rst)
//         Q <= 1'b0;
//     else
//         Q <= D;
// end
//Cuando usas un bloque always @(posedge clk) en Verilog, el código dentro del bloque solo se ejecuta en el flanco de subida (cambio de 0 a 1) de la señal de reloj (clk).
//Solo cuando hay un flanco de subida en clk, el bloque se ejecuta.
//Si en ese momento rst está en 1, Q se pone en 0.
//Si rst está en 0, Q toma el valor de D.