module registradores(rs1, rs2, rd, write_data, wr, read1, read2);

    input [4:0] rs1;          // Endereço do primeiro registrador a ser lido
    input [4:0] rs2;          // Endereço do segundo registrador a ser lido
    input [4:0] rd;           // Endereço do registrador a receber o dado escrito
    input [31:0] write_data;  // Dado a ser escrito
    input wr;                 // Sinal de controle para escrita
    output reg [31:0] read1;  // Valor lido do primeiro registrador
    output reg [31:0] read2;  // Valor lido do segundo registrador

    reg [31:0] regs [0:31];   // Banco de 32 registradores de 32 bits

    initial begin
        regs[0] = 32'd0;  // Inicializa o registrador 0 como zero
        regs[1] = 32'd10; // Inicializa outros registradores com valores
        regs[2] = 32'd20;
        regs[3] = 32'd30;
    end

    always @(*) begin
        read1 = regs[rs1];       // Leitura do primeiro registrador
        read2 = regs[rs2];       // Leitura do segundo registrador
        if (wr) begin
            regs[rd] = write_data; // Escrita no registrador se wr for ativo
        end
    end

endmodule