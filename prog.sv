module prog #(
    parameter Psize = 6,  // 地址数
    Isize = 17  // 指令数   3 + 3 + 3 + 8
) (
    input  logic [Psize-1:0] address,  // 地址
    output logic [Isize-1:0] I         // 指令
);

  // 本质上是一个二维数据，根据地址找到指令 
  // 假设地址位数Psize 那么就会有 2 ^ Psize的地址数  1<<Psize == 2 ^ Psize
  // 这种表示方法是合并数组与非合并数组组合使用
  // https://blog.csdn.net/qq_33332955/article/details/107641152
  logic [Isize-1:0] progMem[(1<<Psize)-1:0];

  // 加载指令到内存中  这里也可以是txt文件
  initial begin
    $readmemb("prog_test.bin", progMem);
  end

  // 赋值
  always_comb I = progMem[address];

endmodule
