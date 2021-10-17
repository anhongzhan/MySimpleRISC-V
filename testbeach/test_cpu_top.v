`include "../src/CPU_TOP.v"
`timescale 1ps/1ps
module test_cpu_top();
    
  reg clk, rst;
  integer counter = 0;
  integer i = 0;
  CPU_TOP My_CPU_TOP(clk, rst);

  initial begin
    clk <= 1;
    rst <= 0;
    #110 rst <= 1;
    #110 rst <= 0;
    $readmemh("../test_instr.dat", My_CPU_TOP.MyInstr_Mem.IM);
    $display("data memory %x", My_CPU_TOP.MyInstr_Mem.IM[0]);
  end

  always begin
    #(50) clk = ~clk;
    if(counter >= 18) $finish;
  end

  always @(negedge clk) begin
    #10
    if(counter >= 0) begin
      $display("# pc %x", My_CPU_TOP.pc);

      $display("|reg_file(i)|x(i)|x(i+1)|x(i+2)|x(i+3)|");
      $display("|-|-|-|-|-|");
      for(i=0; i<32; i=i+4)
        $display("|%d|%x|%x|%x|%x|", i, My_CPU_TOP.MyregisterFile.register[i], My_CPU_TOP.MyregisterFile.register[i+1], My_CPU_TOP.MyregisterFile.register[i+2], My_CPU_TOP.MyregisterFile.register[i+3]);
      $display("|**data_memory(i)**|**+0**|**+4**|**+8**|**+c**|");
      for(i=0; i<12; i++)
        $display("|%x| %x| %x| %x| %x|", i*4*4, My_CPU_TOP.MyMDR.DATA[i*4], My_CPU_TOP.MyMDR.DATA[i*4+1], My_CPU_TOP.MyMDR.DATA[i*4+2], My_CPU_TOP.MyMDR.DATA[i*4+3]);
      counter = counter + 1;
    end;
  end

  initial
  begin            
      $dumpfile("test_cpu_top.vcd");  //生成的vcd文件名称
      $dumpvars(0, test_cpu_top);       //tb模块名称
  end

endmodule