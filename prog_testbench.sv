
module prog_tb;

  // Parameters
  localparam Psize = 4;
  localparam Isize = 17;

  //Ports
  reg  [Psize-1:0] address;
  wire [Isize-1:0] I;

  prog #(
      .Psize(Psize),
      .Isize(Isize)
  ) prog_inst (
      .address(address),
      .I      (I)
  );

  initial begin
    // 产生vcd波形图 vcd flush
    $dumpfile("prog.vcd");
    $dumpvars(1, prog_inst);  //将所有的变量都加进来
  end
  initial begin
    address = 4'b0000;
    #10ns address = 4'b0001;
    #10ns address = 4'b0010;
    #10ns address = 4'b0011;
    #10ns address = 4'b0100;
    #10ns address = 4'b0101;
    #10ns address = 4'b0110;
    #10ns address = 4'b0111;
    #10ns address = 4'b1000;
    #10ns address = 4'b1001;
    #10ns address = 4'b1010;
    #10ns address = 4'b1011;
    #10ns address = 4'b1100;
    #10ns address = 4'b1101;
    #10ns address = 4'b1110;
    #10ns address = 4'b1111;
    $stop;
  end


endmodule
