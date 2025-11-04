module d_fifo(clk_w, clk_r, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter);

input clk_w, clk_r, rst, wr_en, rd_en;
input [7:0] buf_in;
output reg [7:0] buf_out;
output reg buf_empty, buf_full;
output reg [7:0] fifo_counter;

reg [3:0] rd_ptr, wr_ptr; // Tail and head
reg [7:0] buf_mem[63:0];  // buffer mem 64 bits
reg [7:0] wr_count, rd_count; // separate counters

// Status flags
always @(*) begin
    buf_empty = (fifo_counter == 0);
    buf_full  = (fifo_counter == 64);
end

// Write count (write domain)
always @(posedge clk_w or posedge rst) begin
    if (rst)
        wr_count <= 0;
    else if (!buf_full && wr_en)
        wr_count <= wr_count + 1;
end

// Read count (read domain)
always @(posedge clk_r or posedge rst) begin
    if (rst)
        rd_count <= 0;
    else if (!buf_empty && rd_en)
        rd_count <= rd_count + 1;
end

// Combine counts safely (combinational)
always @(*) begin
    fifo_counter = wr_count - rd_count;
end

// Data fetch
always @(posedge clk_r or posedge rst) begin
    if (rst)
        buf_out <= 0;
    else if (rd_en && !buf_empty)
        buf_out <= buf_mem[rd_ptr];
end

// Data store
always @(posedge clk_w) begin
    if (wr_en && !buf_full)
        buf_mem[wr_ptr] <= buf_in;
end

// Pointer initialization
always @(posedge clk_w or posedge rst) begin
    if (rst)
        wr_ptr <= 0;
    else if (!buf_full && wr_en)
        wr_ptr <= wr_ptr + 1;
end

always @(posedge clk_r or posedge rst) begin
    if (rst)
        rd_ptr <= 0;
    else if (!buf_empty && rd_en)
        rd_ptr <= rd_ptr + 1;
end

endmodule
