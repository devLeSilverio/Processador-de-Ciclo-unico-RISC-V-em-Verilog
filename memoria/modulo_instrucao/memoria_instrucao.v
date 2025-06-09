module memoria_instrucao(endereco, dado);

    input [7:0] endereco; // entrada (index por palavra de 32 bits)
    output reg [31:0] dado; // saida

    reg [31:0] memoria [0:255]; // 256 instrucoes de 32 bits

    initial begin
        // lw x1, 0(x0)       # x1 = Mem[0]
        memoria[0] = 32'b0000000_00000_00000_010_00001_0000011;

        // sw x1, 0(x0)       # Mem[0] = x1
        memoria[1] = 32'b0000000_00001_00000_010_00000_0100011;

        // add x2, x1, x1     # x2 = x1 + x1 (deve ser 10 se x1 = 5)
        memoria[2] = 32'b0000000_00001_00001_000_00010_0110011;

        // beq x2, x1, 4      # se x2 == x1, salta +4 bytes (1 instrucao)
        memoria[3] = 32'b0000000_00001_00010_000_00001_1100011;

        // nop (add x0, x0, x0)
        memoria[4] = 32'b0000000_00000_00000_000_00000_0110011;
    end 

    always @(*) begin
        dado = memoria[endereco]; // leitura
    end

endmodule