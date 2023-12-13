module topmodule(
input clk,reset,language,confirm_d,confirm_withd,confirm_lang,
input [1:0]cardId,password,
input [1:0]operation,
input [15:0]depositValue,withdrawValue,
output time_out,
output reg [15:0]balance
);
parameter card1=2'b00,card2=2'b01,card3=2'b10,card4=2'b11;
parameter p1=2'b00,p2=2'b01,p3=2'b10;
parameter cardin=3'b000,passState=3'b001,langState=3'b010,opMenu=3'b011,anotherServiceState=3'b100,cardout=3'b101;
parameter deposit=2'b00,withdraw=2'b01,balanceService=2'b10,cardoutop=2'b11;
parameter English=1'b0,Arabic=1'b1;

reg [1:0]cards[2:0];
reg [1:0]passwords[2:0];
reg [15:0]balances[2:0];
reg languages[1:0];
reg [1:0] counter;
reg [2:0] current_state, next_state;
reg verified;
reg syslang;
reg restart;

timer idle_timer(clk,reset,restart,time_out);

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
always @ (posedge clk or posedge reset)
begin
    if(reset) begin
    current_state<=cardin;
    restart<=1;
    counter<=0;
    end
    else
    current_state<=next_state;
end


always @ (current_state or operation or cardId or password  or depositValue or withdrawValue)
begin

case (current_state)

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
            next_state=langState;
        end
        else if(counter<3)
            begin
            counter=counter+1;
            $display("transition");
            next_state=passState;
            end
        else begin
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
            restart=1;
            next_state = cardin;
    end

    default:
        next_state=cardin;
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
    // withdraw=0;
    restart =0;
 end


end
endtask

endmodule