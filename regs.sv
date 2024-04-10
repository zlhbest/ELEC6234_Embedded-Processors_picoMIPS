module regs #(
    parameter n = 8  // 意思是数据位宽为8
) (
    input  logic                clk,
    write,
    input  logic        [n-1:0] Wdata,
    input  logic        [  2:0] Raddr1,
    Raddr2,  // 地址一共有几个需要看需要多少个寄存器
    output logic signed [n-1:0] Rdata1,
    Rdata2  // 输出的数据
);
  // TODO 这里假设需要8个寄存器
  logic [n-1:0] reg_array[7:0];

  // 写入数据 如果允许写入就写到 地址2中   opcode %1 %2 imm
  always_ff @(posedge clk) begin
    if (write) reg_array[Raddr1] <= Wdata;
  end

  // 这是读取数据
  always_comb begin
    if (Raddr1 == 0) Rdata1 = {n{1'b0}};
    else Rdata1 = reg_array[Raddr1];

    if (Raddr2 == 0) Rdata2 = {n{1'b0}};
    else Rdata2 = reg_array[Raddr2];
  end

endmodule