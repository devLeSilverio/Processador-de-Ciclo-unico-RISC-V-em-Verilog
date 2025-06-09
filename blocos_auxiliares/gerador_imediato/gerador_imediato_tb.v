`timescale 1ps/1ps
`include "gerador_imediato.v"

module gerador_imediato_tb;

reg [31:0] instruction;
wire [31:0] immediate;

gerador_imediato uut (
    .instruction(instruction),
    .immediate(immediate)
);

initial begin
    $dumpfile("gerador_imediato_tb.vcd");
    $dumpvars(0, gerador_imediato_tb);

    // Teste 1: addi x1, x2, 5
    instruction = 32'b00000000010100010000000010010011; // imm = 5
    #20;
    $display("Teste 1 - instruction = %b, immediate = %d", instruction, immediate);

    // Teste 2: sw x2, 0(x1)
    instruction = 32'b00000000001000001000000000100011; // imm = 0
    #20;
    $display("Teste 2 - instruction = %b, immediate = %d", instruction, immediate);

    // Teste 3: beq x1, x2, 16
    instruction = 32'b00000000001000001000100001100011; // imm = 16
    #20;
    $display("Teste 3 - instruction = %b, immediate = %d", instruction, immediate);

    #20;
    $display("Teste Completo");
    $finish;
end

endmodule