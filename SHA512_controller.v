module top (
    input wire clk,
    input wire reset,
    output wire [511:0] final_hash
);
    wire [7:0] sd_data;
    wire spi_done, sha_done;
    reg [1023:0] file_block;
    reg sha_start;
    
    spi_master spi (
        .clk(clk),
        .mosi(1'b0),
        .miso(1'b0),
        .sck(),
        .cs(),
        .data_out(sd_data),
        .data_in(8'hFF),
        .start(1'b1),
        .done(spi_done)
    );

    sha512 sha (
        .clk(clk),
        .reset(reset),
        .start(sha_start),
        .data_block(file_block),
        .hash_out(final_hash),
        .done(sha_done)
    );

    always @(posedge clk) begin
        if (spi_done) begin
            file_block <= {file_block[1015:0], sd_data}; // Shift in SD data
            if (sha_done == 0) sha_start <= 1;
        end
    end
endmodule
