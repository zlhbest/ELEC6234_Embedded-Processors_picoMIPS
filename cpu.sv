module cpu #(
    parameter n = 8
) (
    input  logic         clk,
    input  logic         reset,
    input  logic         sw8,
    input  logic [n-1:0] sws,     //  这个就是X1与Y1的输入 从开关上输入
    output logic [n-1:0] display  //  这里的输出输出的是ALU中Wdata的值 其实不是真正我们需要的x2与y2  这里的设想是我使用特性寄存器来存储结果并且只显示该寄存器的值
);

  // ALU单元
  logic [  1:0] ALUfunc;
  logic         imm;
  logic [n-1:0] b_or_imm;
  logic         imm_or_sw;  //  该数据是来自于程序的立即数还是开关

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
      .flag  (sw8),
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
      .opcode   (instruction_code[Isize-1:Isize-3]),
      .ALUFunc  (ALUfunc),
      .PCincr   (PCincr),
      .imm      (imm),
      .imm_or_sw(imm_or_sw),
      .write    (write)
  );
  // 寄存器 这里简单粗暴的直接链接算了
  logic signed [n-1:0] x2, y2;
  regs #(
      .n(n)
  ) Regs (
      .clk   (clk),
      .write (write),
      .Wdata (Wdata),
      .Raddr1(instruction_code[Isize-4:Isize-6]),
      .Raddr2(instruction_code[Isize-7:Isize-9]),
      .Rdata1(Rdata1),
      .Rdata2(Rdata2),
      .x2    (x2),
      .y2    (y2)
  );
  // ALU
  // 这里需要将a 的data2输入与MUX 的data1 对换 画个图就明白了
  alu #(
      .n(n)
  ) ALU (
      .a      (Rdata2),
      .b      (b_or_imm),
      .ALUFunc(ALUfunc),
      .result (Wdata)
  );

  // MUX imm有两个来源 一个是程序中的立即数 一个是开关中的数字
  always_comb begin
    if (imm) begin
      // 第二个MUX 选择是来自开关还是程序中的选择器 1 是来自立即数 0代表来自开关
      if (imm_or_sw) b_or_imm = instruction_code[n-1:0];
      else b_or_imm = sws;
    end else b_or_imm = Rdata1;
  end

  // 展示ALU中的结果
  //   assign display = Wdata;
  // 这里根据sw的属性来显示display  开关1 reg7 开关0 reg8
  always_ff @(posedge clk) begin
    if (!sw8) display = x2;
    else display = y2;
  end
endmodule
