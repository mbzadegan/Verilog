module Sorting #(parameter N = 8)(
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal
    input wire [31:0] data_in[N-1:0], // Input array
    output reg [31:0] sorted_bubble[N-1:0], // Sorted array (Bubble Sort)
    output reg [31:0] sorted_insertion[N-1:0], // Sorted array (Insertion Sort)
    output reg [31:0] time_bubble,  // Processing time for Bubble Sort
    output reg [31:0] time_insertion // Processing time for Insertion Sort
);

    reg [31:0] bubble_array[N-1:0];
    reg [31:0] insertion_array[N-1:0];
    integer i, j;
    reg done_bubble, done_insertion;

    initial begin
        time_bubble = 0;
        time_insertion = 0;
        done_bubble = 0;
        done_insertion = 0;
    end

    // Bubble Sort
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            done_bubble <= 0;
            for (i = 0; i < N; i = i + 1) bubble_array[i] <= data_in[i];
        end else if (!done_bubble) begin
            integer t_start, t_end;
            t_start = $time;
            for (i = 0; i < N-1; i = i + 1) begin
                for (j = 0; j < N-1-i; j = j + 1) begin
                    if (bubble_array[j] > bubble_array[j+1]) begin
                        reg [31:0] temp;
                        temp = bubble_array[j];
                        bubble_array[j] = bubble_array[j+1];
                        bubble_array[j+1] = temp;
                    end
                end
            end
            t_end = $time;
            time_bubble <= t_end - t_start;
            done_bubble <= 1;
            for (i = 0; i < N; i = i + 1) sorted_bubble[i] <= bubble_array[i];
        end
    end

    // Insertion Sort
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            done_insertion <= 0;
            for (i = 0; i < N; i = i + 1) insertion_array[i] <= data_in[i];
        end else if (!done_insertion) begin
            integer t_start, t_end;
            t_start = $time;
            for (i = 1; i < N; i = i + 1) begin
                reg [31:0] key;
                integer k;
                key = insertion_array[i];
                k = i - 1;
                while (k >= 0 && insertion_array[k] > key) begin
                    insertion_array[k+1] = insertion_array[k];
                    k = k - 1;
                end
                insertion_array[k+1] = key;
            end
            t_end = $time;
            time_insertion <= t_end - t_start;
            done_insertion <= 1;
            for (i = 0; i < N; i = i + 1) sorted_insertion[i] <= insertion_array[i];
        end
    end

endmodule
