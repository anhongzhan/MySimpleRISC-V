module Instr_Mem (
    input  [31:0] addr,
    output [31:0] instr
);

    reg [31:0] IM[0:31];
    assign instr = IM[addr[6:2]];
    
endmodule