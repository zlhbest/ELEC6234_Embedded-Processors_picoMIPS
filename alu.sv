`include "alucodes.sv"
module alu #(
    parameter n = 8  // 数据一共8位
) (
    input  logic signed [n-1:0] a,
    b,  // 输入的两个数字
    input  logic        [  1:0] ALUFunc,  //函数名
    output logic        [n-1:0] result
);
  logic [2*n-1:0] m = 0;
  always_latch begin
    result = 0;
    case (ALUFunc)
      `RB: result = b;
      `ADD: begin
        result = a + b;
      end
      `MUL: begin
        m      = a * b;
        // 如果是14：7 就代表舍弃小数部分 只计算整数部分
        result = m[2*n-2 : n-1];
      end
    endcase
  end

endmodule
