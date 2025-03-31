module matrix_multiplication_3x3 (
    input [15:0] A [0:2][0:2],  // 3x3 Matrix A
    input [15:0] B [0:2][0:2],  // 3x3 Matrix B
    output reg [31:0] C [0:2][0:2]  // 3x3 Result Matrix C
);
    integer i, j, k;

    always @(*) begin
        // Initialize the result matrix C to 0.
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                C[i][j] = 0;
            end
        end

        // Matrix multiplication
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                for (k = 0; k < 3; k = k + 1) begin
                    C[i][j] = C[i][j] + (A[i][k] * B[k][j]);
                end
            end
        end
    end
endmodule
