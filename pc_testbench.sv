`timescale 1ns / 1ps
module pc_tb;

  // Parameters
  localparam Psize = 6;

  //Ports
  reg              clk;
  reg              reset;
  reg              PCincr;
  wire [Psize-1:0] PCout;

  pc #(
      .Psize(Psize)
  ) pc_inst (
      .clk   (clk),
      .reset (reset),
      .PCincr(PCincr),
      .PCout (PCout)
  );

  // 设置时钟
  initial begin
    clk = 0;
    forever #5ns clk = ~clk;
  end
  initial begin
    // 产生vcd波形图 vcd flush
    $dumpfile("pc.vcd");
    $dumpvars(1, pc_inst);  //将所有的变量都加进来
  end
  // 这里定义reset 10ns后下降，10ns后再次上升
  initial begin
    reset = 1;  // 复位一下给一个初始值
    #10ns reset = 0;
    #10ns reset = 0;
    #10ns reset = 0;
    #10ns reset = 1;  // 复位 输出应该为0
  end
  // 定义进位
  initial begin
    PCincr = 0;
    #10ns PCincr = 1;
    #10ns PCincr = 1;
    #10ns PCincr = 1;
    #10ns PCincr = 1;
    #10ns PCincr = 1;
    $stop;
  end


endmodule