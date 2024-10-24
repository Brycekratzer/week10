module div(
    input clock,
    input reset,
    output reg div_clock
);
    reg intreset;
    wire [16:0] intcount;

    // Instantiate the counter
    counter #(.WIDTH(17)) count(
        .clock(clock),
        .reset(intreset),
        .count(intcount)
    );

    // Synchronous logic block
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // If we get reset, pass it through
            // to the counter and reset output clock
            intreset <= 1;
            div_clock <= 0;
        end 
        else if (intcount == 100000) begin
            // Reset the counter and toggle output clock
            intreset <= 1;
            div_clock <= ~div_clock;
        end 
        else begin
            // Otherwise, just continue counting
            intreset <= 0;
        end
    end

endmodule