module random_generator (
    input wire clk,         // Clock input
    input wire reset,       // Reset input
    output reg [7:0] random_number  // 8-bit random number output
);

    reg [15:0] counter;     // 16-bit counter to create variability
    reg [7:0] noise;        // 8-bit noise register to mix with counter
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 16'b0;           // Reset counter
            noise <= 8'b10101010;       // Initialize noise with a non-zero seed
        end else begin
            // Increment counter continuously
            counter <= counter + 1;
            
            // Shift noise and XOR with the counter for random-like behavior
            noise <= {noise[6:0], noise[7] ^ noise[5] ^ noise[3] ^ noise[1]};
        end
    end

    // Combine counter and noise for the output random number
    always @(*) begin
        random_number = counter[7:0] ^ noise;
    end

endmodule
