module clock_div
#(
    parameter DIVIDE_BY = 17 // Or 100,000 for counter implementation
)
(
    input clock,
    input reset,
    output reg div_clock // Slowed down clock
);

// Register array for flip-flop chain
// each bit represents one stage of division
reg [DIVIDE_BY-1:0] div_chain;

// synchronous logic block, sensitive to rising edge of clock or reset
always@(posedge clock or posedge reset) begin
    if(reset) begin
        // reset all flip-flops and output to known state
        div_chain <= 0;
        div_clock <= 0;
    end else begin
        // first flip-flop toggles every clock cycle
        div_chain[0] <= ~div_chain[0];
        //each subsequent flip-flop follows previous one
        div_clock[DIVIDE_BY-1:1] <= div_clock[DIVIDE_BY-2:0];
        // Output takes state of final flip-flop in chain
        div_clock <= div_chain[DIVIDE_BY-1];
    end
end

endmodule