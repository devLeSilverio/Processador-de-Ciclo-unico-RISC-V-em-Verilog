module controle(
    input [6:0] opcode,
    output reg ALUSrc,
    output reg PCSrc,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg MemtoReg,
    output reg Branch,  
    output reg [1:0] ALUOp
);

always @(*) begin
    case (opcode)
        7'b0110011: begin  // Type R (add)
            ALUSrc = 0;
            PCSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            RegWrite = 1;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b10;
        end
        7'b0000011: begin  // lw
            ALUSrc = 1;
            PCSrc = 0;
            MemRead = 1;
            MemWrite = 0;
            RegWrite = 1;
            MemtoReg = 1;
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b0100011: begin  // sw
            ALUSrc = 1;
            PCSrc = 0;
            MemRead = 0;
            MemWrite = 1;
            RegWrite = 0;
            MemtoReg = 0;  // Não importa (X)
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b1100011: begin  // beq
            ALUSrc = 0;
            PCSrc = 1;
            MemRead = 0;
            MemWrite = 0;
            RegWrite = 0;
            MemtoReg = 0;  // Não importa (X)
            Branch = 1;
            ALUOp = 2'b01;
        end
        default: begin  // Caso inválido
            ALUSrc = 0;
            PCSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            RegWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
    endcase
end

endmodule