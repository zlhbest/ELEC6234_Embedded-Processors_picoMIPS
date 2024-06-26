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
    PCincr    = 1'b0;
    imm_or_sw = 1'b0;
    case (opcode)
      `NOP: ;
      // 不做任何处理 NOP 
      `ADD: begin  // 010 add
        write  = 1'b1;
        imm    = 1'b0;
        PCincr = 1'b1;
      end
      `LOAD: begin
        write = 1'b1;
        imm   = 1'b1;
      end
      `ADDI, `MULI: begin  // addI.mulI 是立即数的加和乘 100 代表load
        write     = 1'b1;
        imm_or_sw = 1'b1;  // 只有需要读立即数的时候才会变成1
        imm       = 1'b1;
        PCincr    = 1'b1;
      end
      default: begin

      end
    endcase
  end

endmodule
