module alu_ctrl (
    input [1:0] alu_ctrl_op,
    input [6:0] func7,
    input [2:0] func3,
    output reg [3:0] aluop
);

    always @(*) begin
        case(alu_ctrl_op) 
            2'b00: aluop <= 4'b0010;
            2'b01: aluop <= 4'b0110;
            2'b10: begin
                case(func3)
                    3'b110:  aluop <= 4'b0001;
                    3'b111:  aluop <= 4'b0000;
                    3'b000:  aluop <= {1'b0,func7[5],2'b10};
                    default: aluop <= 4'b0000;                      
                endcase
            end
            default: aluop <= 4'b0000;               
        endcase
    end
    
endmodule