module regs #(
    parameter n = 8  // 意思是数据位宽为8
) (
    input  logic                clk,
    input  logic                write,
    input  logic        [n-1:0] Wdata,
    input  logic        [  1:0] Raddr1,  // 只需要两位即可
    Raddr2,  // 地址一共有几个需要看需要多少个寄存器
    output logic signed [n-1:0] Rdata1,
    Rdata2,  // 输出的数据
    output logic signed [n-1:0] x2,
    y2
);
  // 这里假设需要4个寄存器  只需要4个寄存器 4个寄存器  那就少了两位
  logic [n-1:0] reg_array[3:0];

  assign x2 = reg_array[2];
  assign y2 = reg_array[3];

  // 写入数据 如果允许写入就写到 地址1中   opcode %1 %2 imm 
  always_ff @(posedge clk) begin
    if (write) reg_array[Raddr1] <= Wdata;
  end

  // 这是读取数据 0号寄存器被征用了
  always_comb begin
    Rdata1 <= reg_array[Raddr1];
    Rdata2 <= reg_array[Raddr2];
  end

endmodule
