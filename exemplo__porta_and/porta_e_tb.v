`timescale 1ns/1ns // Unidade de tempo
`include "porta_e.v" // Import do módulo que desenvolvemos anteriormente
module porta_e_tb; // Criacao do modulo de teste
    reg A, B; // Dois registradores para armazenar os valores
    wire S; // Fio para conectar o resultado a saída

porta_e uut(A, B, S); // Instancia da porta E a ser testada
initial begin // Inicio do teste
    $dumpfile("porta_e_tb.vcd"); // Criação do arquivo de resultado
    $dumpvars(0, porta_e_tb); // Variáveis a serem guardadas
    A = 0; // Seta o valor da variável A para 0
    B = 0; // Seta o valor da variável B para 0
    #20; // Aguarda 20 unidades de tempo (20ns)
    A = 0;
    B = 1;
    #20;
    A = 1;
    B = 0;
    #20;
    A = 1;
    B = 1;
    #20;
    $display("Teste completo"); // Escreve uma mensagem de fim de teste
    end
endmodule
