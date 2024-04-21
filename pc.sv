// PC 的功能主要有以下几个：
// * 让PCout 指向下一个地址   目前先实现这个指向下一个 也就是在PCout加1
// * 根据jump跳转到指定地址
module pc #(
    parameter Psize = 6  // 代表pc能指向多大的内存地址
) (
    input  logic             clk,     // 时钟
    input  logic             reset,   // 复位键
    input  logic             PCincr,  // increment the PC (high) or load the PC (low)
    input  logic             flag,
    output logic [Psize-1:0] PCout    // 输出的是指向内存的地址
);
  logic add = 0;
  logic sign = 0;
  // 下降沿的时候触发
  always_ff @(negedge flag, posedge reset, posedge sign) begin
    if (reset) add <= 0;
    else begin
      if (sign) add <= 0;
      // 当sign为0 flag为0的时候才执行
      else if (!flag) add <= 1;
    end
  end
  // PCincr 只有等于1 的时候才往下走  PCincr控制是否阻塞住 要求是
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      PCout <= {Psize{1'b0}};  // 如果是复位命令  那么全部变为0
      sign  <= 0;
    end else begin
      // 没有阻塞 就+1
      if (PCincr) PCout <= PCout + 1;
      else begin
        if (add) begin
          PCout <= PCout + 1;
          sign  <= 1;
        end else sign <= 0;
      end
    end
  end

endmodule
