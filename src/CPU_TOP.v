`include "../src/alu_ctrl.v"
`include "../src/alu.v"
`include "../src/CU.v"
`include "../src/Instr_decoder.v"
`include "../src/Instr_Mem.v"
`include "../src/MDR.v"
`include "../src/nextpc.v"
`include "../src/PC.v"
`include "../src/registerFile.v"
`include "../src/ZeroToExtend.v"

module CPU_TOP (
    input clk,
    input rst
);

    //PC
    wire [31:0] pc;
    
    //nextpc
    wire [31:0] nextpc;

    //Instr_Mem
    wire [31:0] instr;

    //Instr_decoder
    wire [6:0]  opcode;
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [4:0]  rd;
    wire [6:0]  func7;
    wire [2:0]  func3;

    //CU
    wire ALUSrcB;
    wire ALUM2Reg;
    wire MDRW;
    wire RegWire;
    wire branch;
    wire [1:0] alu_ctrl_op;
    wire [1:0] Imm_Ctrl;

    //ZeroToExtend
    wire [31:0] Imm;

    //registerFile
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    //2 * 1 -> MUX
    wire [31:0] alu_data2;

    assign alu_data2 = (ALUSrcB == 1'b1) ? Imm : read_data2;

    //alu_ctrl
    wire [3:0] aluop;

    //alu
    wire [31:0] alu_output;
    wire zero;

    //MDR
    wire [31:0] Data_From_MDR;

    PC MyPC(
        .clk(clk),
        .rst(rst),
        .nextPC(nextpc),
        .PC(pc)
    );

    nextpc Mynextpc(
        .zero(zero),
        .branch(branch),
        .Imm(Imm),
        .pc(pc),
        .nextpc(nextpc)
    );

    Instr_Mem MyInstr_Mem(
        .addr(pc),
        .instr(instr)
    );

    Instr_decoder MyInstr_decoder(
        .instr(instr),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func7(func7),
        .func3(func3)
    );

    CU MyCU(
        .instr(instr),
        .ALUSrcB(ALUSrcB),
        .ALUM2Reg(ALUM2Reg),
        .MDRW(MDRW),
        .RegWire(RegWire),
        .branch(branch),
        .alu_ctrl_op(alu_ctrl_op),
        .Imm_Ctrl(Imm_Ctrl)
    );

    ZeroToExtend MyZeroToExtend(
        .instr(instr),
        .Imm_Ctrl(Imm_Ctrl),
        .Imm(Imm)
    );

    registerFile MyregisterFile(
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .Data_From_ALU(alu_output),
        .Data_From_MDR(Data_From_MDR),
        .ALUM2Reg(ALUM2Reg),             
        .RegWire(RegWire),              
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    alu_ctrl Myalu_ctrl(
        .alu_ctrl_op(alu_ctrl_op),
        .func7(func7),
        .func3(func3),
        .aluop(aluop)
    );

    alu Myalu(
        .aluop(aluop),
        .alu_data1(read_data1),
        .alu_data2(alu_data2),
        .alu_output(alu_output),
        .zero(zero)
    );

    MDR MyMDR(
        .clk(clk),
        .rst(rst),
        .MDRW(MDRW),
        .Data_From_alu(alu_output),   
        .write_data(read_data2),        //rs2
        .Data_From_MDR(Data_From_MDR) 
    );
    
endmodule