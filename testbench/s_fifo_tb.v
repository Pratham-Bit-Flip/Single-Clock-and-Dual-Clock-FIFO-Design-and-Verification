`timescale 1ns/1ps

module s_fifo_tb;

   
    reg clk, rst;
    reg wr_en, rd_en;
    reg [7:0] buf_in;
    wire [7:0] buf_out;
    wire buf_empty, buf_full;
    wire [7:0] fifo_counter;

// Instantiate 
    FIFO dut (
        .clk(clk),
        .rst(rst),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .fifo_counter(fifo_counter)
    );

// Clock generation (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;

// Waveform dump
    initial begin
        $dumpfile("fifo_tb.vcd");
        $dumpvars(0, fifo_tb);
    end

// Monitor all signals
    initial begin
        $monitor("time=%0t | wr_en=%b rd_en=%b buf_in=%h buf_out=%h count=%0d empty=%b full=%b", $time, wr_en, rd_en, buf_in, buf_out, fifo_counter, buf_empty, buf_full);
    end
 
// Initialization
 initial begin
          rst=1; wr_en = 0; rd_en = 0; buf_in=8'h00;// Initialization
          #10;

          rst=0;

//write value
          wr_en = 1; buf_in = 8'h11;
          #10;
          buf_in = 8'h22; #10;
          buf_in = 8'h33; #10;
          buf_in = 8'h44; #10;
          wr_en = 0;

//read_phase
          rd_en=1;
          #10;
          #10;
          #10;
          rd_en=0;

//mix phase
          wr_en = 1; rd_en = 0; buf_in = 8'hAA; #10;
          wr_en = 0; rd_en = 1; #10;
          wr_en = 1; rd_en = 0; buf_in = 8'hBB; #10;
          wr_en = 0; rd_en = 1; #10;
          wr_en = 1; rd_en = 0; buf_in = 8'hCC; #10;
          wr_en = 0; rd_en = 1; #10;

// final check
          wr_en = 0; rd_en = 0;
          #20;
          $display("\nSimulation finished successfully.");
          $finish;
end
endmodule 
