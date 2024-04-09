`include "opcodes.sv"
module decoder (
    input  logic [2:0] opcode,   // 操作数
    output logic [1:0] ALUFunc,  // ALU函数
    output logic       PCincr,   // PC control
    output logic       imm,      //是读取立即数还是寄存器
    output logic       write     //是否写入寄存器
);

  always_comb begin
    ALUFunc = opcode[1:0];  // 操作数的后两位变成了ALU的函数
    imm     = 1'b0;
    write   = 1'b0;
    PCincr  = 1'b1;  // 读取下一行
    case (opcode)
      `NOP: ;  // 不做任何处理 NOP
      `ADD: begin  // 010 add
        write = 1'b1;
        imm   = 1'b0;
      end
      `ADDI, `MULI, `LOAD: begin  // addI.mulI 是立即数的加和乘 100 代表load
        write = 1'b1;
        imm   = 1'b1;
      end
      default: begin
        $error("unimplemented opcode %h", opcode);
      end
    endcase
  end

endmodule
