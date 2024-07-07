import uvm_pkg::*;
`include "interface.sv"
//`include "uvm_macros.svh"
import adder_pkg::*;
module top;
  bit clk;

  aintf intf(.clk(clk));  

  Adder #(.bits(4)) adder(
    .clk(intf.clk),
    .A(intf.A),
    .B(intf.B),
    .sum(intf.sum),
    .cout(intf.cout)
  );
  always begin
    #5 clk = ~clk;
  end

  initial begin
    #10000
    $finish;
  end
  initial begin
    uvm_config_db#(virtual aintf)::set(null, "*", "intf", intf);
    run_test("test");
  end
endmodule
