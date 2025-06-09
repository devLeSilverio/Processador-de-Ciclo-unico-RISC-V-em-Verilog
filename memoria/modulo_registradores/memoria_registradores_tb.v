`timescale 1ps/1ps
`include "memoria_registradores.v"

module registradores_tb;

    reg [4:0] rs1, rs2, rd;
    reg [31:0] write_data;
    reg wr;
    wire [31:0] read1, read2;

    registradores uut (
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .wr(wr),
        .read1(read1),
        .read2(read2)
    );

    initial begin
        $dumpfile("memoria_registradores_tb.vcd");
        $dumpvars(0, registradores_tb);

        // Teste 1: Leitura inicial dos registradores 1 e 2
        rs1 = 5'd1; 
        rs2 = 5'd2; 
        wr = 0; #20;
        $display("Teste 1 - Leitura inicial: read1 = %d, read2 = %d", read1, read2);

        // Teste 2: Escrita no registrador 4 com valor 1234
        rd = 5'd4; 
        write_data = 32'd1234; 
        wr = 1; #20;
        wr = 0; #5;
        $display("Teste 2 - Apos escrita: read1 = %d, read2 = %d (registrador 4 nao lido diretamente)", read1, read2);

        // Teste 3: Leitura do registrador 4 e outro registrador
        rs1 = 5'd4; 
        rs2 = 5'd1; 
        #20;
        $display("Teste 3 - Leitura de registrador 4: read1 = %d, read2 = %d", read1, read2);

        // Teste 4: Escrita e leitura imediata no mesmo registrador
        rd = 5'd5; 
        write_data = 32'd5678; 
        wr = 1; 
        rs1 = 5'd5; 
        rs2 = 5'd0; 
        #20;
        wr = 0; #5;
        $display("Teste 4 - Escrita e leitura em 5: read1 = %d, read2 = %d", read1, read2);

        $display("Teste Completo");
    end
endmodule