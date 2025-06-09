`timescale 1ps/1ps
`include "memoria_dados.v"

module memoria_dados_tb;

    reg [31:0] rs;
    reg [31:0] wd;
    reg wr;
    wire [31:0] rd;

    memoria_dados uut (
        .rs(rs),
        .wd(wd),
        .wr(wr),
        .rd(rd)
    );

    initial begin
        $dumpfile("memoria_dados_tb.vcd");
        $dumpvars(0, memoria_dados_tb);

        // Teste 1: Leitura inicial do endereco 1
        rs = 32'd1; wr = 0; #20;
        $display("Teste 1 - Leitura inicial (endereco 1): rd = %d", rd);

        // Teste 2: Escrita no endereco 500 com valor 2000
        rs = 32'd500; wd = 32'd2000; wr = 1; #20;
        wr = 0; #5;
        $display("Teste 2 - Apos escrita (endereco 500): rd = %d", rd);

        // Teste 3: Leitura do endereco 500
        rs = 32'd500; wr = 0; #20;
        $display("Teste 3 - Leitura (endereco 500): rd = %d", rd);

        // Teste 4: Escrita e leitura imediata no endereco 100
        rs = 32'd100; wd = 32'd3000; wr = 1; #20;
        $display("Teste 4 - Leitura imediata (endereco 100): rd = %d", rd);

        $display("Teste Completo");
        #20 $finish;
    end
endmodule