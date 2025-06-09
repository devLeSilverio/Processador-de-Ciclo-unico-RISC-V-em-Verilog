`timescale 1ps/1ps
`include "ula_control.v"

module ula_control_tb;

    // Sinais de entrada
    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg [6:0] funct7;

    // Sinal de saída
    wire [3:0] ula_op;

    // Instanciação do módulo a ser testado
    ula_control uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ula_op(ula_op)
    );

    // Bloco inicial para simulação
    initial begin
        $dumpfile("ula_control_tb.vcd");  // Arquivo para visualização no GTKWAVE
        $dumpvars(0, ula_control_tb);     // Variáveis a serem dumpadas

        // Teste 1: lw/sw (ALUOp = 00)
        ALUOp = 2'b00; funct3 = 3'b000; funct7 = 7'b0000000;
        #20;
        $display("Teste 1 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 2: beq (ALUOp = 01)
        ALUOp = 2'b01; funct3 = 3'b000; funct7 = 7'b0000000;
        #20;
        $display("Teste 2 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 3: add (R-Format, ALUOp = 10)
        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000;
        #20;
        $display("Teste 3 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 4: sub (R-Format, ALUOp = 10)
        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0100000;
        #20;
        $display("Teste 4 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 5: and (R-Format, ALUOp = 10)
        ALUOp = 2'b10; funct3 = 3'b111; funct7 = 7'b0000000;
        #20;
        $display("Teste 5 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 6: or (R-Format, ALUOp = 10)
        ALUOp = 2'b10; funct3 = 3'b110; funct7 = 7'b0000000;
        #20;
        $display("Teste 6 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 7: Caso inválido (R-Format com funct inválido)
        ALUOp = 2'b10; funct3 = 3'b001; funct7 = 7'b0000000;
        #20;
        $display("Teste 7 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        // Teste 8: ALUOp inválido
        ALUOp = 2'b11; funct3 = 3'b000; funct7 = 7'b0000000;
        #20;
        $display("Teste 8 - ALUOp=%b, funct3=%b, funct7=%b, ula_op=%b", ALUOp, funct3, funct7, ula_op);

        #20;
        $display("Teste Completo");
        $finish;
    end

endmodule