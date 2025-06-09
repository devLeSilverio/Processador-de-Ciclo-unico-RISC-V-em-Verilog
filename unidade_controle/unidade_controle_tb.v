`timescale 1ps/1ps
`include "unidade_controle.v"

module controle_tb;

reg [6:0] opcode;
wire ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch;

controle uut (
    .opcode(opcode),
    .ALUSrc(ALUSrc),
    .PCSrc(PCSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch)
);

initial begin
    $dumpfile("unidade_controle_tb.vcd");
    $dumpvars(0, controle_tb);

    // Teste 1: R-Format (add)
    opcode = 7'b0110011;
    #20;
    $display("Teste 1 - opcode = %b, ALUSrc=%b PCSrc=%b MemRead=%b MemWrite=%b RegWrite=%b MemtoReg=%b Branch=%b",
             opcode, ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch);

    // Teste 2: lw
    opcode = 7'b0000011;
    #20;
    $display("Teste 2 - opcode = %b, ALUSrc=%b PCSrc=%b MemRead=%b MemWrite=%b RegWrite=%b MemtoReg=%b Branch=%b",
             opcode, ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch);

    // Teste 3: sw
    opcode = 7'b0100011;
    #20;
    $display("Teste 3 - opcode = %b, ALUSrc=%b PCSrc=%b MemRead=%b MemWrite=%b RegWrite=%b MemtoReg=%b Branch=%b",
             opcode, ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch);

    // Teste 4: beq
    opcode = 7'b1100011;
    #20;
    $display("Teste 4 - opcode = %b, ALUSrc=%b PCSrc=%b MemRead=%b MemWrite=%b RegWrite=%b MemtoReg=%b Branch=%b",
             opcode, ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch);

    #20;
    $display("Teste Completo");
    $finish;
end

endmodule