module picoMIPS #(
    parameter n = 8
) (
    input  logic         clk,
    input  logic         reset,
    input  logic         sw8,
    input  logic [n-1:0] sws,     //  这个就是X1与Y1的输入 从开关上输入
    output logic [n-1:0] display
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

  // 开关关下来的时候 pc指示变成1
  always_ff @(negedge sw8) begin
    $display("change PCincr value from 0 to 1, sw = %b , PCincr = %b", sw8, PCincr);
    PCincr <= 1'b1;
  end
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
      .opcode   (instruction_code[Isize-1:Isize-3]),
      .ALUFunc  (ALUfunc),
      .PCincr   (PCincr),
      .imm      (imm),
      .imm_or_sw(imm_or_sw),
      .write    (write)
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
      .ALUFunc(ALUfunc),
      .result (Wdata)
  );

  // MUX imm有两个来源 一个是程序中的立即数 一个是开关中的数字
  always_comb begin
    if (imm) begin
      // 第二个MUX 选择是来自开关还是程序中的选择器 1 是来自立即数 0代表来自开关
      if (imm_or_sw) b_or_imm = instruction_code[n-1:0];
      else b_or_imm = sws;
    end else b_or_imm = Rdata2;
  end

  // 展示ALU中的结果
  assign display = Wdata;
endmodule
