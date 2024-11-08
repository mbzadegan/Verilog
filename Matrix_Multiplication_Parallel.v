module matrix_multiplication #(
    parameter M = 2, // Number of rows in A and C
    parameter N = 2, // Number of columns in A and rows in B
    parameter P = 2  // Number of columns in B and C
)(
    input clk,                   // Clock signal
    input reset,                 // Reset signal
    input start,                 // Start signal for operation
    input [31:0] A [M-1:0][N-1:0], // Input matrix A (M x N)
    input [31:0] B [N-1:0][P-1:0], // Input matrix B (N x P)
    output reg [31:0] C [M-1:0][P-1:0], // Output matrix C (M x P)
    output reg done               // Done signal indicating completion
);

    // Internal registers for computation
    reg [31:0] sum;
    integer i, j, k;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset matrix C and done signal
            done <= 0;
            for (i = 0; i < M; i = i + 1) begin
                for (j = 0; j < P; j = j + 1) begin
                    C[i][j] <= 32'b0;
                end
            end
        end else if (start) begin
            done <= 0;  // Reset done signal at the start of computation
            // Parallel computation of each element in the result matrix C
            for (i = 0; i < M; i = i + 1) begin
                for (j = 0; j < P; j = j + 1) begin
                    sum = 32'b0; // Initialize sum for each C[i][j]
                    // Perform the dot product for C[i][j]
                    for (k = 0; k < N; k = k + 1) begin
                        sum = sum + A[i][k] * B[k][j];
                    end
                    C[i][j] <= sum;  // Store result in C[i][j]
                end
            end
            done <= 1;  // Set done signal when multiplication is complete
        end
    end
endmodule
