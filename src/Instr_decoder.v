module Instr_decoder(
    input  [31:0] instr,
    output reg [6:0]  opcode,
    output reg [4:0]  rs1,
    output reg [4:0]  rs2,
    output reg [4:0]  rd,
    output reg [6:0]  func7,
    output reg [2:0]  func3
   // output [11:0] Imm
);

    always @(*) begin
        opcode = instr[6:0];
        rs1 = instr[19:15];
        rs2 = instr[24:20];
        rd  = instr[11:7];
        func7    = instr[31:25];
        func3    = instr[14:12];
    end
    
endmodule