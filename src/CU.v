module CU (
    input [31:0] instr,
    output reg ALUSrcB,
    output reg ALUM2Reg,
    output reg MDRW,
    output reg RegWire,
    output reg branch,
    output reg [1:0] alu_ctrl_op,
    output reg [1:0] Imm_Ctrl
);

    wire [6:0] opcode;
    assign opcode = instr[6:0];

    always @(*) begin
        ALUSrcB  = (~opcode[6]) & (~(opcode[5] & opcode[4]));       //ori lw sw
        ALUM2Reg = (~opcode[6]) & (~opcode[5]) & (~opcode[4]);      // lw
        MDRW     = (opcode == 7'b0100011) ? 1 : 0;                  // sw
        RegWire  = (opcode[5]) & (~opcode[4]);                      // 1->不需要写入寄存器
        alu_ctrl_op[0] = opcode[6] & opcode[5] & (~opcode[4]);                    //beq -> *1
        alu_ctrl_op[1] = (~opcode[6]) & (opcode[4]);                               //add sub or and ori -> 10      sw lw -> 00
        Imm_Ctrl = opcode[6:5];
        branch   = opcode[6];
    end
    
endmodule