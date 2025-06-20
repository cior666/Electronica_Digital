`timescale 1ns / 1ps

module TFI_tb;

    // Entradas
    reg clk;
    reg reset;
    reg botonA;
    reg botonB;

    // Salidas
    wire [3:0] leds;

    // Instancia del módulo TFI
    TFI uut (
        .clk(clk),
        .reset(reset),
        .botonA(botonA),
        .botonB(botonB),
        .leds(leds)
    );

    // Generador de reloj
    always #10 clk = ~clk; // Reloj de 50 MHz (20 ns por ciclo)

    initial begin
        // Inicialización del archivo .vcd
        $dumpfile("TFI_tb.vcd"); // Nombre del archivo .vcd
        $dumpvars(0, TFI_tb);    // Registra todas las variables del módulo TFI_tb

        // Inicialización
        clk = 0;
        reset = 1;
        botonA = 0;
        botonB = 0;

        // Liberamos el reset
        #20 reset = 0;

        // Simulamos el patrón de ingreso de un auto
        #20000 botonA = 1;  // Presionamos botonA (20 us)
        #20000 botonB = 1;  // Presionamos botonB (20 us)
        #20000 botonA = 0;  // Soltamos botonA (20 us)
        #20000 botonB = 0;  // Soltamos botonB (20 us)

        // Esperamos para observar el resultado
        #100000;

        // Simulamos el patrón de egreso de un auto
        #20000 botonB = 1;  // Presionamos botonB (20 us)
        #20000 botonA = 1;  // Presionamos botonA (20 us)
        #20000 botonB = 0;  // Soltamos botonB (20 us)
        #20000 botonA = 0;  // Soltamos botonA (20 us)

        // Esperamos para observar el resultado
        #100000;

        // Finalizamos la simulación
        $finish; // Finaliza la simulación correctamente
    end
endmodule
