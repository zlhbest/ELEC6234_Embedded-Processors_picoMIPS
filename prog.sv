module prog #(
    parameter Psize = 6,  // 地址数
    Isize = 24  // 指令数
) (
    input  logic [Psize-1:0] address,  // 地址
    output logic [  Isize:0] I         // 指令
);

  // 本质上是一个二维数据，根据地址找到指令 
  // 假设地址位数Psize 那么就会有 2 ^ Psize的地址数  1<<Psize == 2 ^ Psize
  logic [Isize-1:0] progMem[(1<<Psize)-1:0];

  // 加载指令到内存中  这里也可以是txt文件
  initial begin
    $readmemb("prog.bin", progMem);
  end

  // 赋值
  always_comb I = progMem[address];

endmodule
