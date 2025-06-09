module datapath (
    input wire clk,
    input wire reset,
    output wire [31:0] pc_atual
);

    // Registradores e fios
    reg [31:0] pc;                        // Registrador do PC
    wire [31:0] instrucao;                // Instrução lida da memória
    wire [6:0] opcode;                    // Opcode da instrução
    wire [4:0] rs1, rs2, rd;              // Endereços dos registradores
    wire [2:0] funct3;                    // Campo funct3 da instrução
    wire [6:0] funct7;                    // Campo funct7 da instrução
    wire [31:0] dado_reg1, dado_reg2;     // Dados lidos dos registradores
    wire [31:0] imediato;                 // Valor imediato gerado
    wire [31:0] operando_ula;             // Segundo operando da ULA (saída do mux)
    wire [31:0] resultado_ula;            // Resultado da ULA
    wire [31:0] dado_memoria;             // Dado lido da memória
    wire [31:0] dado_escrita;             // Dado a ser escrito nos registradores

    // Sinais de controle
    wire reg_escrita, mem_escrita, alu_src, mem_para_reg, branch;
    wire [1:0] alu_op;
    wire [3:0] operacao_ula;
    wire pc_src;

    
    memoria_instrucao mem_instrucao (
        .endereco(pc[7:2]),              // Usa os 6 bits menos significativos
        .dado(instrucao)
    );

    
    assign opcode  = instrucao[6:0];
    assign rd      = instrucao[11:7];
    assign funct3  = instrucao[14:12];
    assign rs1     = instrucao[19:15];
    assign rs2     = instrucao[24:20];
    assign funct7  = instrucao[31:25];

    controle unidade_controle (
        .opcode(opcode),
        .ALUSrc(alu_src),
        .PCSrc(pc_src),
        .MemRead(reg_escrita),           
        .MemWrite(mem_escrita),
        .RegWrite(reg_escrita),          
        .MemtoReg(mem_para_reg),
        .Branch(branch),
        .ALUOp(alu_op)
    );

    registradores banco_registradores (
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(dado_escrita),
        .wr(reg_escrita),
        .read1(dado_reg1),
        .read2(dado_reg2)
    );

    gerador_imediato gerador_imediato (
        .instruction(instrucao),
        .immediate(imediato)
    );

    mux mux_alu (
        .data_input_0(dado_reg2),
        .data_input_1(imediato),
        .select_signal(alu_src),
        .out_selected_data(operando_ula)
    );

    ula_control controle_ula (
        .ALUOp(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .ula_op(operacao_ula)
    );

    ula unidade_ula (
        .A(dado_reg1),
        .B(operando_ula),
        .UlaOp(operacao_ula),
        .Out(resultado_ula)
    );

    memoria_dados mem_dados (
        .rs(resultado_ula),
        .wd(dado_reg2),
        .wr(mem_escrita),
        .rd(dado_memoria)
    );

    mux mux_escrita (
        .data_input_0(resultado_ula),
        .data_input_1(dado_memoria),
        .select_signal(mem_para_reg),
        .out_selected_data(dado_escrita)
    );

    // Lógica de atualização do PC
    wire [31:0] pc_mais_4 = pc + 4;
    wire [31:0] pc_branch = pc + imediato;
    wire branch_condicao = branch & (resultado_ula == 0);  // beq toma branch se igual
    wire proximo_pc = pc_src & branch_condicao;            // Usa PCSrc do diagrama
    assign pc_atual = proximo_pc ? pc_branch : pc_mais_4;

    // Atualização do PC com clock e reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc_atual;
    end

endmodule