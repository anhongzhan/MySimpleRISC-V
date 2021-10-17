`define IMM_I_TYPE  2'b00
`define IMM_S_TYPE  2'b01
`define IMM_B_TYPE  2'b11

module ZeroToExtend (
    input [31:0] instr,
    input [1:0]  Imm_Ctrl,
    output reg [31:0] Imm
);

    always @(*) begin
        case(Imm_Ctrl)
            `IMM_I_TYPE: Imm <= {{20{instr[31]}}, instr[31:20]};
            `IMM_S_TYPE: Imm <= {{20{instr[31]}}, instr[31:25], instr[11:7]};
            `IMM_B_TYPE: Imm <= {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            default :    Imm <= 32'b0;
        endcase
    end
    
endmodule