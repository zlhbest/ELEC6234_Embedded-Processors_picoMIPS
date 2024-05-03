module picoMIPS #(
    parameter n = 8
) (
    input  logic         clk,
    input  logic         reset,
    input  logic         sw8,
    input  logic [n-1:0] sws,     //  这个就是X1与Y1的输入 从开关上输入
    output logic [n-1:0] display, //  这里的输出输出的是ALU中Wdata的值 其实不是真正我们需要的x2与y2  这里的设想是我使用特性寄存器来存储结果并且只显示该寄存器的值

    output logic [6:0] digits,      // 个位数
    output logic [6:0] ten_digits,  // 十位数
    output logic [6:0] hun_digits,  // 百位数
    output logic [6:0] sign         // 符号
);

  //为了防止抖动  模拟的时候去掉
  logic slow_clk;
  counter c (
      .fastclk(clk),
      .clk    (slow_clk)
  );  // slow clk from counter

  cpu #(
      .n(n)
  ) CPU (
      .clk    (slow_clk),
      .reset  (reset),
      .sw8    (sw8),
      .sws    (sws),
      .display(display)
  );
  // 来一个显示数据
  number Number_Display (
      .display   (display),
      .digits    (digits),
      .ten_digits(ten_digits),
      .hun_digits(hun_digits),
      .sign      (sign)
  );
endmodule
