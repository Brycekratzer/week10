module top
#(
    parameter DIVIDE_BY = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, // Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);
    wire reset = btnC;
    wire div_clock = clk;
    wire [3:0]A;
    wire [3:0]B;
    wire [3:0]AplusB;
    wire [3:0]AminusB;

    clock_div #(.DIVIDE_BY(DIVIDE_BY)) clk_div(
        .clock(clk),
        .reset(reset),
        .div_clock(div_clock)
    );

    math_block math(
        .A(sw[3:0]),
        .B(sw[7:4]),
        .AplusB(AplusB[3:0]),
        .AminusB(AminusB[3:0])
    );

    seven_seg_scanner seven_scnner(
        .div_clock(div_clock),
        .reset(reset),
        .anode(an[3:0])
    );

    seven_seg_decoder seven_seg_decode(
        .A(sw[3:0]),
        .B(sw[7:4]),
        .AplusB(AplusB[3:0]),
        .AminusB(AminusB[3:0]),
        .anode(an[3:0]),
        .segs(seg[6:0])
    );

endmodule