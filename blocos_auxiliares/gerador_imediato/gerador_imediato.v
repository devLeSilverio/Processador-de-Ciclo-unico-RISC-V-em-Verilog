module gerador_imediato(
    input [31:0] instruction,    // Instrução completa de 32 bits
    output reg [31:0] immediate  // Valor imediato de 32 bits gerado
);

wire [6:0] opcode;
assign opcode = instruction[6:0];

always @(*) begin
    case (opcode)
        7'b0010011, // I-type (addi)
        7'b0000011, // lw
        7'b1100111: // jalr
            immediate = {{20{instruction[31]}}, instruction[31:20]};

        7'b0100011: // S-type (sw)
            immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

        7'b1100011: // B-type (beq)
            immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};

        default:
            immediate = 32'b0;
    endcase
end

endmodule