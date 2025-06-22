/* INTEGRANTES
Ciorciari Conrado 
Da Silva Catela Justo*/
`timescale 1ns / 1ps

module TFI_tb;
// Inputs
reg CLK;
reg BTN1; // BotonA
reg BTN2; // BotonB
// Outputs
wire LED3;
wire LED2;
wire LED1;
wire LED0;

reg [3:0] contador_anterior;

TFI uut (
    .CLK(CLK),
    .BTN1(BTN1),
    .BTN2(BTN2),
    .LED3(LED3),
    .LED2(LED2),
    .LED1(LED1),
    .LED0(LED0)
);

initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end
// Monitor para observar cambios
always @(posedge CLK) begin
    if ({LED3,LED2,LED1,LED0} != contador_anterior) begin
        $display("Tiempo: %t - Contador cambió de %d a %d", $time, contador_anterior, {LED3,LED2,LED1,LED0});
        contador_anterior = {LED3,LED2,LED1,LED0};
    end
end

initial begin
    $dumpfile("TFI_tb.vcd");
    $dumpvars(0, TFI_tb);
    // Inicializamos los inputs
    BTN1 = 0;
    BTN2 = 0;
    contador_anterior = 0;
    
    #100;
    $display("=== INICIO DE SIMULACION ===");
    $display("Contador inicial: %d", {LED3,LED2,LED1,LED0});
    // Test 1: Secuencia de ENTRADA completa
    $display("\n=== TEST 1: ENTRADA COMPLETA ===");
    #1000000; // Esperar para antirebote
    // Paso 1: A=1, B=0
    BTN1 = 1; BTN2 = 0;
    $display("Paso 1 - A=1, B=0");
    #1000000;
    // Paso 2: A=1, B=1
    BTN1 = 1; BTN2 = 1;
    $display("Paso 2 - A=1, B=1");
    #1000000;
    // Paso 3: A=0, B=1
    BTN1 = 0; BTN2 = 1;
    $display("Paso 3 - A=0, B=1");
    #1000000;
    // Paso 4: A=0, B=0 (debe incrementar contador)
    BTN1 = 0; BTN2 = 0;
    $display("Paso 4 - A=0, B=0 (ENTRADA COMPLETA)");
    #1000000;
    $display("Contador después de entrada: %d", {LED3,LED2,LED1,LED0});
    
    // Test 2: Secuencia de SALIDA completa
    $display("\n=== TEST 2: SALIDA COMPLETA ===");
    #1000000;
    // Paso 1: A=0, B=1
    BTN1 = 0; BTN2 = 1;
    $display("Paso 1 - A=0, B=1");
    #1000000;
    // Paso 2: A=1, B=1
    BTN1 = 1; BTN2 = 1;
    $display("Paso 2 - A=1, B=1");
    #1000000;
    // Paso 3: A=1, B=0
    BTN1 = 1; BTN2 = 0;
    $display("Paso 3 - A=1, B=0");
    #1000000;
    // Paso 4: A=0, B=0 (debe decrementar contador)
    BTN1 = 0; BTN2 = 0;
    $display("Paso 4 - A=0, B=0 (SALIDA COMPLETA)");
    #1000000;
    $display("Contador después de salida: %d", {LED3,LED2,LED1,LED0});
    // Test 3: Secuencia incompleta (no deberia cambiar contador)
    $display("\n=== TEST 3: SECUENCIA INCOMPLETA ===");
    #1000000;
    BTN1 = 1; BTN2 = 0;
    $display("Secuencia incompleta: A=1, B=0");
    #1000000;
    BTN1 = 0; BTN2 = 0; // Secuencia incompleta
    $display("Volviendo a A=0, B=0 sin completar secuencia");
    #1000000;
    $display("Contador después de secuencia incompleta: %d", {LED3,LED2,LED1,LED0});
    // Test 4: Activación simultánea (caso problemático original)
    $display("\n=== TEST 4: ACTIVACION SIMULTANEA (CASO PROBLEMATICO) ===");
    #1000000;
    BTN1 = 1; BTN2 = 1;
    $display("Activación simultánea A=1, B=1 (NO debe incrementar contador)");
    #1000000;
    BTN1 = 0; BTN2 = 0;
    $display("Volviendo a A=0, B=0");
    #1000000;
    $display("Contador después de activación simultánea: %d", {LED3,LED2,LED1,LED0});
    // Test 5: Múltiples entradas
    $display("\n=== TEST 5: MULTIPLES ENTRADAS ===");
    repeat(3) begin
        #1000000;
        // Secuencia entrada completa
        BTN1 = 1; BTN2 = 0; #1000000;
        BTN1 = 1; BTN2 = 1; #1000000;
        BTN1 = 0; BTN2 = 1; #1000000;
        BTN1 = 0; BTN2 = 0; #1000000;
        $display("Entrada %d completada. Contador: %d", 3-2, {LED3,LED2,LED1,LED0});
    end
    $display("\n=== FIN DE SIMULACION ===");
    $display("Contador final: %d", {LED3,LED2,LED1,LED0});
    $finish;
end

endmodule 