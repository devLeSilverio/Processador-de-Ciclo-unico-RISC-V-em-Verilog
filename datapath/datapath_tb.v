`timescale 1ns/1ps

module datapath_tb;
    reg         clk   = 0;
    reg         reset = 1;
    wire [31:0] pc_atual, instrucao;
    wire [31:0] dado_reg1, dado_reg2;
    wire [31:0] resultado_ula, dado_memoria, dado_escrita;

    datapath dut (
        .clk           (clk),
        .reset         (reset),
        .pc_atual      (pc_atual),
        .instrucao     (instrucao),
        .dado_reg1     (dado_reg1),
        .dado_reg2     (dado_reg2),
        .resultado_ula (resultado_ula),
        .dado_memoria  (dado_memoria),
        .dado_escrita  (dado_escrita)
    );

    initial begin
 
        $dumpfile("datapath_tb.vcd");
        $dumpvars(0, datapath_tb);


        #10 reset = 0;
    end


    always #10 clk = ~clk;

    integer cycle = 0;
    always @(posedge clk) begin
        $display("CYCLE=%0d PC=%0d INST=0x%h R1=%0d R2=%0d ALU=%0d MEM=%0d WB=%0d",
                 cycle, pc_atual, instrucao,
                 dado_reg1, dado_reg2,
                 resultado_ula, dado_memoria, dado_escrita);
        cycle = cycle + 1;
        if (cycle == 8) $finish;
    end
endmodule