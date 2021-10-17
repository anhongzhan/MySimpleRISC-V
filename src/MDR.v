//Data memory Register
module MDR (
    input clk,
    input rst,
    input MDRW,                     //是否写入MDR
    input [31:0] Data_From_alu, //存疑2       //ADDR
    input [31:0] write_data,        //rs2
    output reg [31:0] Data_From_MDR         //Data_From_MDR
);
    reg [31:0] DATA[0:255];
    wire [31:0] addr;

    assign addr = {29'b0,Data_From_alu[4:2]};
    
    integer i;
    always @(posedge clk, posedge rst) begin
        if(MDRW) begin
            DATA[addr] <= write_data;
        end
        if(rst) begin
            for(i=0;i<255;i=i+1)
                DATA[i] <= 32'b0;
        end
    end

    always @(*) begin
        Data_From_MDR <= DATA[addr];
    end
    
endmodule