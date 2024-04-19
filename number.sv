// 该文件主要作用是将数据显示在 数码管上有符号的8位二进制数 范围是 -128 —— 127 也就是需要4个数码管 一个数码管是7个组成

`include "number_display.sv"
module number (
    // 这里我直接写死了就
    input logic [7:0] display,

    output logic [6:0] digits,      // 个位数
    output logic [6:0] ten_digits,  // 十位数
    output logic [6:0] hun_digits,  // 百位数
    output logic [6:0] sign         // 符号
);
  logic [3:0] digits_number;
  logic [3:0] ten_number;
  logic [3:0] hub_number;
  logic [6:0] number;
  always_comb begin
    digits     = `ZERO;
    ten_digits = `ZERO;
    hun_digits = `ZERO;
    sign       = `NONE;
    // 确认符号位
    if (display[7]) begin
      sign <= `NEGA;
      number = ((~display) + 1);
    end else begin
      sign   = `NONE;
      number = display[6:0];
    end
    digits_number = number % 10;
    ten_number    = number / 10 % 10;
    hub_number    = number / 100 % 10;
    // 显示
    show_led(digits_number, digits);
    show_led(ten_number, ten_digits);
    show_led(hub_number, hun_digits);


  end

  // 输入二进制显示数字
  function automatic void show_led(input logic [3:0] numbre, ref logic [6:0] digits);
    case (numbre)
      0: digits = `ZERO;
      1: digits = `ONE;
      2: digits = `TWO;
      3: digits = `THREE;
      4: digits = `FORE;
      5: digits = `FIVE;
      6: digits = `SIX;
      7: digits = `SEVEN;
      8: digits = `EIGHT;
      9: digits = `NINE;
      default: begin
        digits = `NONE;
      end
    endcase
  endfunction

endmodule
