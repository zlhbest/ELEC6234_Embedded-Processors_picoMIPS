
module alu_tb;

  // Parameters
  localparam n = 8;

  //Ports
  reg  [n-1:0] a;
  reg  [n-1:0] b;
  reg  [  1:0] ALUFunc;
  wire [n-1:0] result;

  alu #(
      .n(n)
  ) alu_inst (
      .a      (a),
      .b      (b),
      .ALUFunc(ALUFunc),
      .result (result)
  );

  initial begin
    ALUFunc = 2'b10;
    a       = 8'b00000011;  //3
    b       = 8'b00010100;  //20
    #10ns ALUFunc = 2'b11;  //MUL
    a = 8'b01100000;  //0.75
    b = 8'b00000101;  //5;
  end

endmodule
