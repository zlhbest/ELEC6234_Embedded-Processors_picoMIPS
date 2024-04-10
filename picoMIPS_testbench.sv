
module picoMIPS_tb;

  // Parameters
  localparam n = 8;

  //Ports
  reg          clk;
  reg          reset;
  wire [n-1:0] display;


  picoMIPS #(
      .n(n)
  ) picoMIPS_inst (
      .clk    (clk),
      .reset  (reset),
      .display(display)
  );

  // 设置时钟
  initial begin
    clk = 0;
    forever #5ns clk = ~clk;
  end

  initial begin
    reset = 1;  // 重置复位
    #10ns reset = 0;  // 下拉
  end


  initial begin
    // 产生vcd波形图 vcd flush
    $dumpfile("picoMIPS.vcd");
    $dumpvars(1, picoMIPS_inst);  //将所有的变量都加进来
  end

endmodule
