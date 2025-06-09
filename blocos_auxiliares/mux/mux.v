module mux(
    input [31:0] data_input_0,    // Primeira entrada de 32 bits
    input [31:0] data_input_1,    // Segunda entrada de 32 bits
    input select_signal,           // Sinal de seleção de 1 bit
    output reg [31:0] out_selected_data // Saída de 32 bits
);

    always @(*) begin
        if (select_signal == 1'b0) begin
            out_selected_data = data_input_0;    
        end else begin
            out_selected_data = data_input_1;    
        end
    end

endmodule