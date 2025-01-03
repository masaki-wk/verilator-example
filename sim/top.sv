// The top module in SystemVerilog

`include "config.svh"

module top (
    input logic clk,
    input logic rst_n
);

  // The DUT
  logic dut_enb;
  logic dut_carryout;
  Counter #(
      .WIDTH(`DUT_WIDTH)
  ) dut (
      .clk     (clk),
      .rst_n   (rst_n),
      .enb     (dut_enb),
      // verilator lint_off PINCONNECTEMPTY
      .count   (  /*open*/),
      // verilator lint_on PINCONNECTEMPTY
      .carryout(dut_carryout)
  );

  // The test scenario
  typedef enum logic [1:0] {
    STATE_INITIAL,
    STATE_RUNNING,
    STATE_FINISHED
  } state_e;
  state_e state;
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= STATE_INITIAL;
    end else if (state == STATE_INITIAL) begin
      state <= STATE_RUNNING;
    end else if (state == STATE_RUNNING && dut_carryout) begin
      state <= STATE_FINISHED;
    end else if (state == STATE_FINISHED) begin
      $finish();
    end
  end
  assign dut_enb = (state == STATE_RUNNING);

  // Enable tracing if `+trace` argument specified
  initial begin
    if ($test$plusargs("trace")) begin
      $display("Start tracing to dump.vcd...");
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  end

endmodule
