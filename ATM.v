module topmodule(
input clk,reset,language,card_in,confirm_d,confirm_withd,confirm_lang,confirm_pass,
input [1:0]cardId,password,
input [1:0]operation,
input [15:0]depositValue,withdrawValue,
output time_out,
output reg card_out,
output reg [15:0]balance
);
// Parameters including cards, passwords, states, operations and languages
parameter card1=2'b00,card2=2'b01,card3=2'b10;
parameter p1=2'b00,p2=2'b01,p3=2'b10;
parameter idle=3'b000,cardin=3'b001,passState=3'b010,langState=3'b011,opMenu=3'b100,anotherServiceState=3'b101,cardout=3'b110;
parameter deposit=2'b00,withdraw=2'b01,balanceService=2'b10,cardoutop=2'b11;
parameter English=1'b0,Arabic=1'b1;
//Arrays for storing cards, passwords,balances and languages
reg [1:0]cards[2:0];
reg [1:0]passwords[2:0];
reg [15:0]balances[2:0];
reg languages[1:0];

reg [1:0] counter_p; //password fail counter
reg [2:0] current_state, next_state; // FSM States
reg verified; // verification for that card, password, deposit and withdraw are successful
reg syslang; // System Language

// Time_out timer
reg restart;
timer idle_timer(clk,reset,restart,time_out);

// Arrays initialization
initial 
begin
    cards[0]=card1;
    cards[1]=card2;
    cards[2]=card3;
    passwords[cards[0]]=p1;
    passwords[cards[1]]=p2;
    passwords[cards[2]]=p3;
    balances[cards[0]]=3000;
    balances[cards[1]]=8000;
    balances[cards[2]]=12000;
    languages[English]=English;
    languages[Arabic]=Arabic;
    
end

// State Memory
always @ (posedge clk or posedge reset /*or posedge time_out*/)
begin
    // if(time_out) begin
    //     restart<=1;
    //     next_state<=cardout;
    // end
    if(reset /*| time_out*/) begin
        current_state<=idle;
        restart<=1;
        counter_p<=0;
        balance<=0;
        // card_out<=time_out?1:0;
    end
    else
        current_state<=next_state;
end

// Next State Logic and Output Logic
always @ (*)
begin
// if(time_out)
// next_state=cardout;
// else
// next_state=next_state;
case (current_state)
    idle: begin
        card_out=0;
        counter_p=0;
        if(card_in)
            next_state=cardin;
        else
            next_state=idle;
    end
    cardin:
    begin
        
        checkCard(cardId,balance,verified);
        if(verified)
            next_state=passState;
        else
            next_state=cardout;

    end

    passState:
    begin
        checkPassword(password,verified);
        if(verified) begin
            restart=1;
            next_state=langState;
        end
        else if(counter_p<3)
            begin
            counter_p=counter_p+1;
            next_state=passState;
            end
        
        if(counter_p==3 | time_out) begin
            // restart=time_out?1:0;
            next_state=cardout;
        end
        



    end

    langState:
    begin
        $display("Language here");
        if(confirm_lang) begin
            restart=1;
            syslang=languages[language];
            next_state=opMenu;
        end
        else begin
            restart=time_out?1:0;
            next_state=time_out?cardout:langState;
        end
    end

   opMenu:
    begin
        case (operation)
            deposit:
            begin
                $display("deposit here");
                depositfunc(depositValue);
                if (!restart)
                    restart=time_out?1:0;
                next_state=time_out?cardout:anotherServiceState;
                
            end
            withdraw:
            begin
                withdrawfunc(withdrawValue,verified);
                    if(verified) begin
                        restart=1;
                        next_state=anotherServiceState;
                    end
                    else begin
                        restart=time_out?1:0;
                        next_state=time_out?cardout:anotherServiceState;
                    end
            end

            balanceService:
            begin
                balance=balances[cardId];
                next_state=anotherServiceState;
            end

            cardoutop:
                next_state=cardout;

            default: 
                next_state=anotherServiceState;


            
        endcase
    end
    anotherServiceState: 
        next_state=opMenu;

    cardout: begin
            card_out=1;        
            restart=1;
            next_state = idle;
    end

    default:
        next_state=idle;
endcase
end






task checkCard;

    input [1:0] cardId;
    output reg[31:0] balance;
    output verified;
    begin
    verified = 1;
    balance = 0;
    
    case (cardId)
        cards[0]:begin
             balance = balances[cards[0]];
             $display("Card found");
        end
        cards[1]: begin
             balance = balances[cards[1]];
             $display("Card found");
        end 
        cards[2]: begin
             balance = balances[cards[2]];
             $display("Card found");
        end 
        default : begin
            verified = 0;
            $display("Card is not found");
        end
    endcase
    end
endtask

task checkPassword;
    input [1:0]User_Password;
    output reg pin_verified;
    if(confirm_pass) begin
        restart=1;
        if(User_Password==passwords[cardId]) 
            begin 

            $display("Correct Password");
            pin_verified = 1;

            end
        else 
            begin
            $display("incorrect Password");
            pin_verified = 0;
            end
    end
    else
        restart=0;

endtask

task depositfunc;
input [15:0] amount;
begin
    if(confirm_d)begin
        restart=1;
        balances[cardId] = balances[cardId]+amount;
        balance=balances[cardId];
        $display("Deposited Successfully");
    end
    else begin
        restart=0;
    end
end
endtask

function [0:0] checkbalance;
input [15:0] balancein;
integer diff;
begin
diff = balances[cardId] - balancein;
if(diff<0)
begin
    checkbalance = 1'b0;
    $display("Insufficent Balance");
end
else
begin
    checkbalance = 1'b1;
    $display("Sufficent Balance");
end
end
endfunction


task withdrawfunc;
input [15:0] amount;
output withdraw;
reg can;
begin  
 can = checkbalance(amount);
 if(confirm_withd) begin
    restart=1;
    if(can) begin
        balances[cardId] = balances[cardId]-amount;
        balance=balances[cardId];
        withdraw = 1;
        $display("Money withdraw successful");
    end
    else begin
        withdraw = 0;
        $display("Money withdraw unsuccessful");
    end
 end
 else begin
    restart =0;
 end


end
endtask

endmodule