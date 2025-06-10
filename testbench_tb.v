`timescale 1ns/1ps

module testbench_simple_tb;
    reg        clk   = 0;
    reg        reset = 1;
    wire [31:0] pc_atual, instrucao;
    wire [31:0] R1, R2, U, M, WB;

    // instância do datapath
    datapath dut (
        .clk           (clk),
        .reset         (reset),
        .pc_atual      (pc_atual),
        .instrucao     (instrucao),
        .dado_reg1     (R1),
        .dado_reg2     (R2),
        .resultado_ula (U),
        .dado_memoria  (M),
        .dado_escrita  (WB)
    );

    initial begin
        // programa só com ADD, SUB e BEQ

        // add  x3, x1, x2  → x3 = 5 + 3 = 8
        dut.mem_instrucao.memoria[0] = 32'b0000000_00010_00001_000_00011_0110011;
        // sub  x4, x1, x2  → x4 = 5 - 3 = 2
        dut.mem_instrucao.memoria[1] = 32'b0100000_00010_00001_000_00100_0110011;
        // beq  x3, x4, +8  → se x3==x4 
        dut.mem_instrucao.memoria[2] = 32'b0000000_00100_00011_000_01000_1100011;

        // inicializa registradores x1=5, x2=3
        dut.regs.regs[1] = 32'd5;
        dut.regs.regs[2] = 32'd3;

        $dumpfile("testbench_result.vcd");
        $dumpvars(0, testbench_simple_tb);
        #10 reset = 0;
    end

    always #10 clk = ~clk;

    integer cycle = 0;
    always @(posedge clk) begin
        $display("C=%0d PC=%0d INST=0x%h R1=%0d R2=%0d U=%0d",
                 cycle, pc_atual, instrucao, R1, R2, U);
        cycle = cycle + 1;
        if (cycle == 3) begin
            // checa resultados de ADD e SUB
            if (dut.regs.regs[3] !== 32'd8)
                $fatal(1, "x3 deveria ser 8 mas é %d", dut.regs.regs[3]);
            if (dut.regs.regs[4] !== 32'd2)
                $fatal(1, "x4 deveria ser 2 mas é %d", dut.regs.regs[4]);

            if (pc_atual !== 32'd8)
                $fatal(1, "BEQ alterou o PC incorretamente: PC=%0d", pc_atual);
            $display("### Teste de ADD, SUB e BEQ Passaram (SOCORRO DEUS) ###");
            #10 $finish;
        end
    end

endmodule