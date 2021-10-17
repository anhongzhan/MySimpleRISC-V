module registerFile (
    input clk,
    input rst,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
   // input ALUSrcB,              //alu的第二个输入是来自寄存器还是来自立即数
    input [31:0] Data_From_ALU,
    input [31:0] Data_From_MDR,
  //  input [31:0] Imm,
    input ALUM2Reg,             //写入的内容来自alu输出还是来自数据内存
    input RegWire,              //这条指令是否需要写入
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    reg [31:0] register[31:0];

    integer i;
    initial begin
        for(i=0;i<32;i=i+1) register[i] <= 0;
    end

    always @(*) begin
        read_data1 = (rs1 == 5'b0) ? 32'b0 : register[rs1];
        read_data2 = (rs2 == 5'b0) ? 32'b0 : register[rs2];
    end

    always @(negedge clk, posedge rst) begin
        if(rst) begin
            for(i=1;i<32;i=i+1) register[i] <= 32'b0;
        end
        else begin
            if(rd != 5'b0 && RegWire == 1'b0)
                register[rd] = (ALUM2Reg == 1'b0) ? Data_From_ALU : Data_From_MDR; 
        end
    end
    
endmodule