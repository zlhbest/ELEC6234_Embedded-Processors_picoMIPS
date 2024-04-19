
module number_tb;

  // Parameters

  //Ports
  reg  [7:0] display;
  wire [6:0] digits;
  wire [6:0] ten_digits;
  wire [6:0] hun_digits;
  wire [6:0] sign;

  number number_inst (
      .display   (display),
      .digits    (digits),
      .ten_digits(ten_digits),
      .hun_digits(hun_digits),
      .sign      (sign)
  );

  initial begin
    display = 8'b11101100;
  end

endmodule
