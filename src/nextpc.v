module nextpc (
    input zero,
    input branch,
    input [31:0] Imm,
    input [31:0] pc,
    output [31:0] nextpc
);

    assign nextpc = (branch & zero) ? (pc + Imm) : (pc + 4);
    
endmodule