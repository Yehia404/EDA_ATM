module ATM_tb();
reg clk,reset,language,confirm_d,confirm_withd,confirm_lang;
reg [1:0]cardId,password;
reg [1:0]operation;
reg [15:0]depositValue,withdrawValue;
wire time_out;
wire [15:0]balance;
// integer result;
topmodule atm(clk,reset,language,confirm_d,confirm_withd,confirm_lang,cardId,password,operation,depositValue,withdrawValue,time_out,balance);
// import "DPI-C" function int reference(input bit clk, input bit reset, input bit language, input bit confirm_d, input bit confirm_withd, input bit confirm_lang, input bit [1:0] cardid, input bit [1:0] password, input bit [1:0] operation, input bit [15:0] depositValue, input bit [15:0] withdrawValue);
integer i;


initial begin
    clk=0;
    forever
    #4 clk=~clk;
    
end


// initial
// begin
//     reset=1;
//     result = reference(clk,reset,language,confirm_d,confirm_withd,confirm_lang,cardId,password,operation,depositValue,withdrawValue);
    
// #2  reset=0;
//     confirm_d=1;
//     confirm_withd=0;
//     confirm_lang=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b00;
//     depositValue=16'd256; //256
//     withdrawValue=0;
//     result = reference(clk,reset,language,confirm_d,confirm_withd,confirm_lang,cardId,password,operation,depositValue,withdrawValue);
//     @(negedge clk);
//     $stop;
// //true
// //password incorrect
// //timeout
// //dummy values out of range
// //random
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       //Directed Test Case (True Value)
//     reset=1;                                        // (Deposit) balance=3000, expected output balance=3256

// #2  reset=0;
//     confirm_d=1;
//     confirm_withd=0;
//     confirm_lang=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b00;
//     depositValue=16'd256; 
//     withdrawValue=0;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       //Directed Test Case (True Value)
//     reset=1;                                        //(Withdraw) balance=8000, expected output balance=7744

// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=1;
//     confirm_lang=1;
//     cardId=2'b01;
//     password=2'b01;
//     language=1;
//     operation=2'b01;
//     depositValue=0; 
//     withdrawValue=16'd256;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (True Value)                                           
//     reset=1;                                        // Mix of 3 Operations (Show balance,withdraw,deposit,cardout)
//                                                     //(Withdraw) balance=8000, expected output balance=8744
// #2  reset=0;
//     confirm_d=1;
//     confirm_withd=1;
//     confirm_lang=1;
//     cardId=2'b01;
//     password=2'b01;
//     language=1;
//     operation=2'b10;
// #10
//     operation=2'b01;
//     withdrawValue=16'd256;
// #20
//     operation=2'b00;
//     depositValue=16'd1000;
// #21
//     operation=2'b11;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (Wrong Value)                                           
//     reset=1;                                        //(Password Incorrect) 
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=1;
//     confirm_lang=1;
//     cardId=2'b00;
//     password=2'b01;
//     #5 password=2'b10;
//     #15 password=2'b11;
//     #20 password=3'b011;
//     language=1;
//     operation=2'b01;
//     depositValue=0; 
//     withdrawValue=16'd256;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (Wrong Value)                                           
//     reset=1;                                        //(Card Incorrect) 
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=1;
//     confirm_lang=1;
//     cardId=2'b11;
//     password=2'b01;
//     password=2'b10;
//     language=1;
//     operation=2'b01;
//     depositValue=0; 
//     withdrawValue=16'd256;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (deposit timeout)                                           
//     reset=1;                                        //(delay 50 as threshold is 5 clk cycles which represents 40 unit time as clk_period is 8 )
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=0;
//     confirm_lang=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b00;
//     #50
//     depositValue=16'd256; 
//     withdrawValue=0;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin   
//     reset=1;                                            //Random Test Case
// #2  reset=0;
// for(i=0;i<1000;i=i+1)
// begin
//     confirm_d=$random();
//     confirm_withd=$random();
//     confirm_lang=$random();
//     cardId=$random();
//     password=$random();
//     language=$random();
//     operation=$random();
//     depositValue=$random(); 
//     withdrawValue=$random();
//     @(negedge clk);
// end
// $stop();
// end

initial
    $monitor("%t: language=%b,cardId=%b,password=%b,operation=%b,depositValue=%d,withdrawValue=%d,time_out=%b,balance=%d",$time,language,cardId,password,operation,depositValue,withdrawValue,time_out,balance);



endmodule








