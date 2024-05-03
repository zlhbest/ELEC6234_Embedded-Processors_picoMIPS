
module decoder_tb;

  // Parameters

  //Ports
  reg  [2:0] opcode;
  wire [1:0] ALUFunc;
  wire       imm;
  wire       write;

  decoder decoder_inst (
      .opcode (opcode),
      .ALUFunc(ALUFunc),
      .imm    (imm),
      .write  (write)
  );


  initial begin
    opcode = 3'b000;
    #10ns opcode = 3'b001;
    #10ns opcode = 3'b010;
    #10ns opcode = 3'b110;
    #10ns opcode = 3'b111;
    #10ns opcode = 3'b100;
    $stop;
  end

endmodule
