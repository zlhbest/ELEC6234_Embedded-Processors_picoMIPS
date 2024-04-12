`include "opcodes.sv"
module decoder (
    input  logic [2:0] opcode,     // 操作数
    output logic [1:0] ALUFunc,    // ALU函数
    output logic       PCincr,     // PC control 是否读取下一行
    output logic       imm,        //是读取立即数还是寄存器
    output logic       imm_or_sw,  // 是读取程序中的立即数还是读取开关的
    output logic       write       //是否写入寄存器
);

  always_comb begin
    ALUFunc   = opcode[1:0];  // 操作数的后两位变成了ALU的函数
    imm       = 1'b0;
    write     = 1'b0;
    PCincr    = 1'b1;  //TODO 这里改成1就对了  虽然不知道为啥但是感觉非常神奇。 等quartus 综合出来电路以后看看为什么
    imm_or_sw = 1'b0;
    $display("decoder control opcode = %b", opcode);
    case (opcode)
      `NOP: ;  // 不做任何处理 NOP 
      `ADD: begin  // 010 add
        write  = 1'b1;
        imm    = 1'b0;
        PCincr = 1'b1;  // 读取下一行
      end
      `LOAD: begin
        PCincr = 1'b0;  // LOAD 的时候PCincr 变成0 阻塞住
        write  = 1'b1;
        imm    = 1'b1;
      end
      `ADDI, `MULI: begin  // addI.mulI 是立即数的加和乘 100 代表load
        write     = 1'b1;
        imm_or_sw = 1'b1;  // 只有需要读立即数的时候才会变成1
        imm       = 1'b1;
        PCincr    = 1'b1;  // 读取下一行
      end
      default: begin
        $error("unimplemented opcode %h", opcode);
      end
    endcase
    $display("pc control PCincr = %b", PCincr);
  end

endmodule
