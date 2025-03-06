module aes_rng (
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input [127:0] seed_key,    // 128-bit seed key for AES
    output reg [127:0] rand_num // 128-bit random number output
);
    reg [127:0] counter;       // 128-bit counter for CTR mode
    wire [127:0] aes_out;      // Output of AES encryption

    // Instantiate AES encryption module
    // This AES module should be implemented separately
    
    aes_encrypt aes_inst (
        .clk(clk),
        .reset(reset),
        .key(seed_key),
        .data_in(counter),
        .data_out(aes_out)
    );

    // Update counter and random number on each clock cycle
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize counter and output on reset
            counter <= 128'h0000_0000_0000_0000_0000_0000_0000_0001;
            rand_num <= 128'h0;
        end else begin
            // Encrypt the counter value to get a new random number
            rand_num <= aes_out;

            // Increment counter for the next AES encryption
            counter <= counter + 1;
        end
    end
endmodule
