`timescale 1ps/1ps
`include "memoria_instrucao.v"

module memoria_instrucao_tb;

    reg [7:0] endereco; // Entrada
    wire [31:0] dado;   // Saída

    // Instancia o módulo a ser testado
    memoria_instrucao uut (
        .endereco(endereco),
        .dado(dado)
    );

    initial begin
        $dumpfile("memoria_instrucao_tb.vcd");
        $dumpvars(0, memoria_instrucao_tb);

        // Teste 1: Lê o valor do endereço 0
        endereco = 8'd0; #20;
        $display("Endereco: %d, Dado: %d", endereco, dado);

        // Teste 2: Lê o valor do endereço 1
        endereco = 8'd1; #20;
        $display("Endereco: %d, Dado: %d", endereco, dado);

        // Teste 3: Lê o valor do endereço 2
        endereco = 8'd2; #20;
        $display("Endereco: %d, Dado: %h", endereco, dado);

        // Teste 4: Lê o valor de um endereço não inicializado
        endereco = 8'd3; #20;
        $display("Endereco: %d, Dado: %d", endereco, dado);

        $display("Teste Completo");
    end
endmodule