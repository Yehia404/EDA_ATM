module timer #(parameter threshold=5)(
    input wire clk,
    input wire rst,
    input wire restart,
    output reg time_out
);

reg [31:0] counter;

always @(posedge clk or posedge rst) 
begin
    if (rst) 
    begin
        counter  <=0;
        time_out <=0;
    end 

    else if(restart) begin
            counter <=0;
            time_out <= 0;
        end

    else begin
            counter <= counter + 1;
         end
        
        
        
     if (counter == threshold-1) 
        begin
            time_out <= 1;
            counter  <= 0 ;
        end
        // else
        // begin
        //     time_out <= 0;
        // end
 end
    

endmodule