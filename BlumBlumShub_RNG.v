module bbs_rng (
    input clk,                   // Clock signal
    input reset,                 // Reset signal
    output reg [7:0] random_bit  // 8-bit random output
);
    // Define parameters for primes p and q, and modulus M = p * q
    // Here we use small values for demonstration purposes.
    parameter integer p = 11;     // First prime number (p ≡ 3 mod 4)
    parameter integer q = 19;     // Second prime number (q ≡ 3 mod 4)
    parameter integer M = p * q;  // Modulus M = p * q

    // Internal state of the generator
    reg [31:0] x;  // State variable, keeping it 32-bit to handle larger values

    // Initialize x with a non-zero seed (it should be coprime with M)
    initial x = 3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state to the initial seed
            x <= 3;  // Reset to the initial seed value
            random_bit <= 0;
        end else begin
            // Blum Blum Shub core equation: x = (x * x) % M
            x <= (x * x) % M;

            // Output the least significant bit (LSB) of the current x as the random bit
            random_bit <= x[0];  // Use the LSB of x as the next random bit
        end
    end
endmodule
