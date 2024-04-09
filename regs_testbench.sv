
module regs_tb;

  // Parameters
  localparam n = 8;

  //Ports
  reg          clk;
  reg          write;
  reg  [n-1:0] Wdata;
  reg  [  2:0] Raddr1;
  reg  [  2:0] Raddr2;
  wire [n-1:0] Rdata1;
  wire [n-1:0] Rdata2;

  regs #(
      .n(n)
  ) regs_inst (
      .clk   (clk),
      .write (write),
      .Wdata (Wdata),
      .Raddr1(Raddr1),
      .Raddr2(Raddr2),
      .Rdata1(Rdata1),
      .Rdata2(Rdata2)
  );

  // 设置时钟
  initial begin
    clk = 0;
    forever #5ns clk = ~clk;
  end

  initial begin
    Raddr1 = 5'd0;
    Raddr2 = 5'd0;
    write  = 0;
    $stop;
  end

endmodule
