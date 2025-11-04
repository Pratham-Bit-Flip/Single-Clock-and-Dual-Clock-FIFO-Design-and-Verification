`timescale 1ns/1ps

module d_fifo2_tb;

    reg clk_w, clk_r, rst;
    reg wr_en, rd_en;
    reg [7:0] buf_in;
    wire [7:0] buf_out;
    wire buf_empty, buf_full;
    wire [7:0] fifo_counter;

    // Instantiate 
    FIFO2 dut (
        .clk_w(clk_w),
        .clk_r(clk_r),
        .rst(rst),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .fifo_counter(fifo_counter)
    );

    // Write clock: 10 ns period (100 MHz)
    initial clk_w = 0;
    always #5 clk_w = ~clk_w;

    // Read clock: 15 ns period (~66 MHz)
    initial clk_r = 0;
    always #7.5 clk_r = ~clk_r;

    // Waveform dump
    initial begin
        $dumpfile("fifo2_tb.vcd");
        $dumpvars(0, fifo2_tb);
    end

    // Monitor all signals
    initial begin
        $monitor("time=%0t | wr_en=%b rd_en=%b | buf_in=%h buf_out=%h | count=%0d | empty=%b full=%b",
                 $time, wr_en, rd_en, buf_in, buf_out, fifo_counter, buf_empty, buf_full);
    end

    // Test sequence
    initial begin
        // Reset phase
        rst = 1; wr_en = 0; rd_en = 0; buf_in = 8'h00;
        #20;
        rst = 0;

        // Write some data
        wr_en = 1; buf_in = 8'h11; #20;
        buf_in = 8'h22; #20;
        buf_in = 8'h33; #20;
        buf_in = 8'h44; #20;
        wr_en = 0;

        // Read data
        rd_en = 1; #30;
        #30;
        #30;
        rd_en = 0;

        // Mix phase
        wr_en = 1; rd_en = 0; buf_in = 8'hAA; #20;
        wr_en = 0; rd_en = 1; #30;
        wr_en = 1; rd_en = 0; buf_in = 8'hBB; #20;
        wr_en = 0; rd_en = 1; #30;
        wr_en = 1; rd_en = 0; buf_in = 8'hCC; #20;
        wr_en = 0; rd_en = 1; #30;

        // Final check
        wr_en = 0; rd_en = 0;
        #50;

        $display("\nSimulation finished successfully.");
        $finish;
    end

endmodule
