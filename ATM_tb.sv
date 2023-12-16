module ATM_tb();
reg clk,reset,language,card_in,confirm_d,confirm_withd,confirm_lang,confirm_pass;
reg [1:0]cardId,password;
reg [1:0]operation;
reg [15:0]depositValue,withdrawValue;
wire time_out;
wire card_out;
wire [15:0]balance;
// integer result;
topmodule atm(clk,reset,language,card_in,confirm_d,confirm_withd,confirm_lang,confirm_pass,cardId,password,operation,depositValue,withdrawValue,time_out,card_out,balance);
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
//     // result = reference(clk,reset,language,confirm_d,confirm_withd,confirm_lang,cardId,password,operation,depositValue,withdrawValue);
    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=0;
//     confirm_lang=1;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b01;
//     depositValue=0;
//     #50
//     withdrawValue=16'd256;
//     // result = reference(clk,reset,language,confirm_d,confirm_withd,confirm_lang,cardId,password,operation,depositValue,withdrawValue);
//     @(negedge clk);
//     //$stop;
// //true
// //password incorrect
// //timeout
// //dummy values out of range
// //random
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       //Directed Test Case (True Value)
//     reset=1;                                        // (Deposit then cardout) balance=3000, expected output balance=3256

// #2  reset=0;
//     confirm_d=1;
//     confirm_withd=0;
//     confirm_lang=1;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b00;
//     depositValue=16'd256; 
//     withdrawValue=0;
// #35
//     operation=2'b11;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       //Directed Test Case (True Value)
//     reset=1;                                        //(Withdraw then cardout) balance=8000, expected output balance=7744

// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=1;
//     confirm_lang=1;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b01;
//     password=2'b01;
//     language=1;
//     operation=2'b01;
//     depositValue=0; 
//     withdrawValue=16'd256;
// #35
//     operation=2'b11;
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
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b01;
//     password=2'b01;
//     language=1;
//     operation=2'b10;
// #10
//     operation=2'b01;
//     withdrawValue=16'd256;
    
// #25
//     operation=2'b00;
//     depositValue=16'd1000;
// #20
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
//     confirm_pass=1;
//     card_in=1;
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
//     confirm_pass=1;
//     card_in=1;
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
//     reset=1;                                        //(delay 70 as threshold is 5 clk cycles which represents 40 unit time as clk_period is 8 )
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=0;
//     confirm_lang=1;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b00;
//     #70
//     depositValue=16'd256; 
//     withdrawValue=0;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (withdraw timeout)                                           
//     reset=1;                                        //(delay 70 as threshold is 5 clk cycles which represents 40 unit time as clk_period is 8 )
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=0;
//     confirm_lang=1;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b00;
//     password=2'b00;
//     language=1;
//     operation=2'b01;
//     #70
//     depositValue=0; 
//     withdrawValue=16'd256;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (language timeout)                                           
//     reset=1;                                        //(delay 70 as threshold is 5 clk cycles which represents 40 unit time as clk_period is 8 )
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=0;
//     confirm_lang=0;
//     confirm_pass=1;
//     card_in=1;
//     cardId=2'b00;
//     password=2'b00;
//     operation=2'b01;
//     #70
//     language=1;
//     depositValue=0; 
//     withdrawValue=0;
//     @(negedge clk);
//     $stop;
// end

//-----------------------------------------------------------------------------------------------------------------------------------------------------

// initial begin                                       // Directed Test Case (password timeout)                                           
//     reset=1;                                        //(delay 70 as threshold is 5 clk cycles which represents 40 unit time as clk_period is 8 )
                                                    
// #2  reset=0;
//     confirm_d=0;
//     confirm_withd=1;
//     confirm_lang=1;
//     confirm_pass=0;
//     card_in=1;
//     cardId=2'b00;
//     language=1;
//     operation=2'b01;
//     #70
//     password=2'b00;
//     depositValue=0; 
//     withdrawValue=16'd256;
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
//     confirm_pass=$random();
//     card_in=$random();
//     cardId=$random();
//     password=$random();
//     language=$random();
//     operation=$random();
//     depositValue=$urandom_range(0,30000); 
//     withdrawValue=$urandom_range(0,30000);
//     @(negedge clk);
// end
// $stop();
// end

// psl deposit_assertion: assert always( (confirm_d) -> next[4] (balance == prev(balance) + depositValue )) @(posedge clk); 
// psl withdraw_assertion: assert always( (confirm_withd) -> next[4] (balance == prev(balance) - withdrawValue )) @(posedge clk);

// psl idle_to_cardin_assertion: assert always( (atm.current_state==0) -> next (atm.current_state==1 )) @(posedge clk);
// psl cardin_to_passState_assertion: assert always( (atm.current_state==1) -> next (atm.current_state==2 )) @(posedge clk);
// psl passState_to_langState_assertion: assert always( (atm.current_state==2) -> next (atm.current_state==3 )) @(posedge clk);
// psl LangState_to_opMenu_assertion: assert always( (atm.current_state==3) -> next (atm.current_state==4 )) @(posedge clk);
// psl opMenu_to_anotherService_assertion: assert always( (atm.current_state==4) -> next (atm.current_state==5 )) @(posedge clk);
// psl anotherService_to_cardout_assertion: assert always( (atm.current_state==4 & operation==2'b11) -> next (atm.current_state==6 )) @(posedge clk);

// psl time_out_assertion: assert always( (time_out) -> next[2] (atm.current_state==6 )) @(posedge clk);
// psl password_assertion: assert always( (atm.counter_p==3) -> next (atm.current_state==6 )) @(posedge clk);


integer f;
initial begin
    $monitor("%t: language=%b,cardId=%b,password=%b,operation=%b,depositValue=%d,withdrawValue=%d,time_out=%b,card_out=%b,balance=%d",$time,language,cardId,password,operation,depositValue,withdrawValue,time_out,card_out,balance);
    f=$fopen("output_design.txt","w");
    $fmonitor(f,"balance=%d",balance);
    #1000
    $fclose(f);
    $finish;
end

endmodule








