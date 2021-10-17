module PC (
    input  clk,
    input  rst,
    input  [31:0] nextPC,
    output reg [31:0] PC
);
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            PC <= 32'b0;
        end
        else begin
            PC <= nextPC;
        end  
    end
    
endmodule