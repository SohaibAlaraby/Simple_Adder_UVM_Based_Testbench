module Adder #(
    parameter bits=4
) (
    input bit clk,
    input logic [bits-1 : 0] A,
    input logic [bits-1 : 0] B,
    output logic [bits-1 : 0] sum,
    output logic cout
);
logic [bits : 0] internal;

always @(posedge clk) begin
    internal =  A + B;
    sum = internal[bits-1:0];
    cout = internal[bits];
end
endmodule
