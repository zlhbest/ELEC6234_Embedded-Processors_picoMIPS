// PC 的功能主要有以下几个：
// * 让PCout 指向下一个地址   目前先实现这个指向下一个 也就是在PCout加1
// * 根据jump跳转到指定地址
module pc #(
    parameter Psize = 6  // 代表pc能指向多大的内存地址
) (
    input  logic             clk,     // 时钟
    input  logic             reset,   // 复位键
    input  logic             PCincr,  // increment the PC (high) or load the PC (low)
    output logic [Psize-1:0] PCout    // 输出的是指向内存的地址
);
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      PCout = {Psize{1'b0}};  // 如果是复位命令  那么全部变为0
    end else if (PCincr) begin
      PCout = PCout + 1;  // 如果是移位 那么就代表输出加1
    end
  end

endmodule
