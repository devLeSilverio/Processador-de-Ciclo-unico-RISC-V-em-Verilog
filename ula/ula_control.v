module ula_control (
    input wire [1:0] ALUOp,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [3:0] ula_op
);

always @(*) begin
    case (ALUOp)
        2'b00: begin  // lw e sw
            ula_op = 4'b0010;  // ADD (calcular endereço)
        end
        2'b01: begin  // beq
            ula_op = 4'b0110;  // SUB (comparação)
        end
        2'b10: begin  // R-Format
            case ({funct7, funct3})
                10'b0000000_000: ula_op = 4'b0010;  // add
                10'b0100000_000: ula_op = 4'b0110;  // sub
                10'b0000000_111: ula_op = 4'b0000;  // and
                10'b0000000_110: ula_op = 4'b0001;  // or
                default:         ula_op = 4'bxxxx;  // inválido
            endcase
        end
        default: begin
            ula_op = 4'bxxxx;  // inválido
        end
    endcase
end

endmodule