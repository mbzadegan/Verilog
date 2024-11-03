module lfsr_random (
    input clk,           // Clock input
    input reset,         // Reset input
    output reg [7:0] random_number  // 8-bit random number output
);

    reg [7:0] lfsr;      // 8-bit shift register for LFSR
    wire feedback;       // Feedback bit

    // XOR feedback based on polynomial: x^8 + x^6 + x^5 + x^4 + 1
    assign feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize LFSR with a non-zero value on reset
            lfsr <= 8'b00000001;  // You can use any non-zero seed here
        end else begin
            // Shift LFSR and apply feedback
            lfsr <= {lfsr[6:0], feedback};
        end
    end

    // Output the current state of the LFSR as the random number
    always @(*) begin
        random_number = lfsr;
    end

endmodule
