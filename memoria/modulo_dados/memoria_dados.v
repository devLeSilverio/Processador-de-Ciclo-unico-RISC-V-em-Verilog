module memoria_dados(rs, wd, wr, rd);

    input [31:0] rs;        // Endereco de 32 bits para acessar a memoria
    input [31:0] wd;        // Dado de 32 bits a ser escrito
    input wr;               // Sinal de controle para escrita
    output reg [31:0] rd;   // Dado de 32 bits lido da memoria

    reg [31:0] memoria [0:1023]; // Memoria de 1024 palavras de 32 bits

    initial begin
        memoria[0] = 32'd0;   // Inicializa alguns enderecos como exemplo
        memoria[1] = 32'd100;
        memoria[2] = 32'hA5A5;
    end

    always @(*) begin
        if (wr) begin
            memoria[rs[9:0]] = wd; // Escrita quando wr = 1
        end
        rd = memoria[rs[9:0]]; // Leitura sempre reflete o valor atual
    end

endmodule