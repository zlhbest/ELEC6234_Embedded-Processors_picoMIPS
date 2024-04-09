module picoMIPS #(
    parameter n = 8
) (
    input logic clk,
    input logic reset
);

  // ALU单元
  logic [  1:0] ALUfunc;
  logic         imm;
  logic [n-1:0] b_or_imm;

  // 寄存器
  logic         write;
  logic [n-1:0] Rdata1, Rdata2, Wdata;

  // 程序计数器
  parameter Psize = 4;  // 代表该程序能所有多少行的代码 4代表能搜索 2^4行代码
  logic             PCincr;  // 控制是否移位
  logic [Psize-1:0] ProgAddress;  // 读取的程序地址
  pc #(
      .Psize(Psize)
  ) progCounter (
      .clk   (clk),
      .reset (reset),
      .PCincr(PCincr),
      .PCout (ProgAddress)
  );


  // 程序内存
  parameter Isize = n + 9;  // 一行有多少位 n代表数据位数 加上 3位的操作数 3位的寄存器地址 3位的寄存器地址
  logic [Isize-1:0] instruction_code;  //指令
  prog #(
      .Psize(Psize),
      .Isize(Isize)
  ) progMemory (
      .address(ProgAddress),
      .I      (instruction_code)
  );


  // 解码器
  decoder Decoder (
      .opcode (instruction_code[Isize-1:Isize-3]),
      .ALUFunc(ALUfunc),
      .PCincr (PCincr),
      .imm    (imm),
      .write  (write)
  );
  // 寄存器
  regs #(
      .n(n)
  ) Regs (
      .clk   (clk),
      .write (write),
      .Wdata (Wdata),
      .Raddr1(instruction_code[Isize-4:Isize-6]),
      .Raddr2(instruction_code[Isize-7:Isize-9]),
      .Rdata1(Rdata1),
      .Rdata2(Rdata2)
  );
  // ALU
  alu #(
      .n(n)
  ) ALU (
      .a      (Rdata1),
      .b      (b_or_imm),
      .ALUFunc(ALUFunc),
      .result (Wdata)
  );

  // MUX
  always_comb begin
    if (imm) b_or_imm = instruction_code[n-1:0];
    else b_or_imm = Rdata2;
  end
endmodule
