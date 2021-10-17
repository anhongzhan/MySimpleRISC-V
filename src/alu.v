`include "../include/alu.vh"

module alu(
    input [3:0] aluop,
    input signed [31:0] alu_data1,
    input signed [31:0] alu_data2,
    output reg [31:0] alu_output,
    output zero
);

    always @(*) begin
        case(aluop)
            `ALU_AND: alu_output <= alu_data1 & alu_data2;
            `ALU_OR:  alu_output <= alu_data1 | alu_data2;
            `ALU_ADD: alu_output <= alu_data1 + alu_data2;
            `ALU_SUB: alu_output <= alu_data1 - alu_data2;
            `ALU_NOP: alu_output <= alu_data1;
            default : alu_output <= 0;     
        endcase
    end

    assign zero = (alu_output == 32'b0);

endmodule