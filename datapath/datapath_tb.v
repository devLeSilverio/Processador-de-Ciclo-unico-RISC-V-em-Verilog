module datapath_tb;

    reg clk, reset;
    wire [31:0] pc_atual;

    datapath dut (
        .clk(clk),
        .reset(reset),
        .pc_atual(pc_atual)
    );

    // Geração de clock (período de 10ps, alterna a cada 5ps)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset e execução
    initial begin
        reset = 1;
        #10;
        reset = 0;

        #100;  // Simulação por 100ps após o reset

        $finish;
    end

    // Exibe o PC final e garante o dump
    initial begin
        $dumpfile("datapath_tb.vcd");  // Especifica o arquivo .vcd
        $dumpvars(0, datapath_tb);     // Dump de todas as variáveis do módulo
        #110;  // Após 10ps de reset + 100ps de execução
        $display("PC final: %d", pc_atual);
    end

endmodule