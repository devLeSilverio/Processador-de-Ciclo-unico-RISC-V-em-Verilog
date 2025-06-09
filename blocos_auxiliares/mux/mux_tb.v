`timescale 1ps/1ps
`include "mux.v"

module mux_tb;

    // Declaração das entradas como registradores (reg) para controle no testbench
    reg [31:0] data_input_0;
    reg [31:0] data_input_1;
    reg select_signal;

    // Declaração da saída como wire, pois é conectada ao módulo mux
    wire [31:0] out_selected_data;

    // Instanciação do módulo mux para teste
    mux uut (
        .data_input_0(data_input_0),
        .data_input_1(data_input_1),
        .select_signal(select_signal),
        .out_selected_data(out_selected_data)
    );

    // Bloco inicial para definir os testes
    initial begin
        // Arquivo para salvar a simulação no GTKWAVE
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, mux_tb);

        // Teste 1: Seleção da primeira entrada (select_signal = 0)
        data_input_0 = 32'd10;    // Primeiro valor de entrada (10)
        data_input_1 = 32'd20;    // Segundo valor de entrada (20)
        select_signal = 1'b0;     // Escolhe data_input_0
        #20;                      // Espera 20 picosegundos
        $display("Teste 1 - select_signal = 0: out_selected_data = %d", out_selected_data);

        // Teste 2: Seleção da segunda entrada (select_signal = 1)
        select_signal = 1'b1;     // Escolhe data_input_1
        #20;                      // Espera mais 20 picosegundos
        $display("Teste 2 - select_signal = 1: out_selected_data = %d", out_selected_data);

        // Teste 3: Mudança de valores e nova seleção
        data_input_0 = 32'd50;    // Novo valor para data_input_0 (50)
        data_input_1 = 32'd75;    // Novo valor para data_input_1 (75)
        select_signal = 1'b0;     // Volta a escolher data_input_0
        #20;                      // Espera mais 20 picosegundos
        $display("Teste 3 - select_signal = 0: out_selected_data = %d", out_selected_data);

        // Finaliza a simulação
        #20;
        $display("Teste Completo");
        $finish;
    end

endmodule