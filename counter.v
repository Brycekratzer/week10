module level_counter(
    input clock,            
    input reset,             
    input count,             
    output reg [7:0] value   
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            value <= 'b0
        end else if (count) begin
            value <= value + 1;  
        end
    end
    
endmodule