
module cpu_tb;

  // Parameters
  localparam n = 8;

  //Ports
  reg          clk;
  reg          reset;
  reg          sw8;
  reg  [n-1:0] sws;
  wire [n-1:0] display;


  cpu #(
      .n(n)
  ) cpu_inst (
      .clk    (clk),
      .reset  (reset),
      .sw8    (sw8),
      .sws    (sws),
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
    sw8 = 1'b1;
    // 第一次输入
    #10ns sw8 = 1'b1;
    #20ns sw8 = 1'b0;
    // 第二次输入
    #10ns sw8 = 1'b1;
    #20ns sw8 = 1'b0;
    // 220ns再拉高
    #220ns sw8 = 1'b1;
  end

  initial begin
    // 这里是sw组的输入
    sws = {n{1'b0}};
    // 输入第一个
    #10ns sws = 8'b00001000;
    #40ns sws = 8'b00000100;
  end


endmodule
