module datapath(
    input  wire        clk,
    input  wire        reset,
    output wire [31:0] pc_atual,
    // sinais para debug
    output wire [31:0] instrucao,
    output wire [31:0] dado_reg1,
    output wire [31:0] dado_reg2,
    output wire [31:0] resultado_ula,
    output wire [31:0] dado_memoria,
    output wire [31:0] dado_escrita
);

    // PC
    reg  [31:0] pc;
    wire [31:0] pc_plus4, pc_branch, pc_next;
    wire [7:0]  endereco_instr = pc[9:2];

    // Fetch
    memoria_instrucao mem_instrucao(
        .endereco(endereco_instr),
        .dado     (instrucao)
    );

    // Decode fields
    wire [6:0] opcode   = instrucao[6:0];
    wire [4:0] rd       = instrucao[11:7];
    wire [2:0] funct3   = instrucao[14:12];
    wire [4:0] rs1      = instrucao[19:15];
    wire [4:0] rs2      = instrucao[24:20];
    wire [6:0] funct7   = instrucao[31:25];

    // Controle
    wire        ALUSrc, PCSrc, MemRead, MemWrite, RegWrite, MemtoReg, Branch;
    wire [1:0]  ALUOp;
    controle ucont (
        .opcode   (opcode),
        .ALUSrc   (ALUSrc),
        .PCSrc    (PCSrc),
        .MemRead  (MemRead),
        .MemWrite (MemWrite),
        .RegWrite (RegWrite),
        .MemtoReg (MemtoReg),
        .Branch   (Branch),
        .ALUOp    (ALUOp)
    );

    // Banco de registradores
    registradores regs(
        .rs1       (rs1),
        .rs2       (rs2),
        .rd        (rd),
        .write_data(dado_escrita),
        .wr        (RegWrite),
        .read1     (dado_reg1),
        .read2     (dado_reg2)
    );

    // Gerador de imediato
    wire [31:0] immediate;
    gerador_imediato gen_imm(
        .instruction(instrucao),
        .immediate (immediate)
    );

    // Controle da ULA
    wire [3:0] ula_op;
    ula_control controle_ula(
        .ALUOp  (ALUOp),
        .funct3 (funct3),
        .funct7 (funct7),
        .ula_op (ula_op)
    );

    // Mux de segundo operando da ULA
    wire [31:0] operando_b = ALUSrc ? immediate : dado_reg2;

    // ULA
    ula unidade_ula(
        .A    (dado_reg1),
        .B    (operando_b),
        .UlaOp(ula_op),
        .Out  (resultado_ula)
    );

    // Memória de dados
    memoria_dados mem_data(
        .rs(resultado_ula),
        .wd(dado_reg2),
        .wr(MemWrite),
        .rd(dado_memoria)
    );

    // Mux de write‐back
    assign dado_escrita = MemtoReg ? dado_memoria : resultado_ula;

    // Cálculo de próximo PC
    assign pc_plus4  = pc + 32'd4;
    assign pc_branch = pc + immediate;
    wire branch_taken = Branch && (resultado_ula == 32'd0);
    assign pc_next   = branch_taken ? pc_branch : pc_plus4;

    // Atualização de PC
    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 32'd0;
        else       pc <= pc_next;
    end

    assign pc_atual = pc;

endmodule