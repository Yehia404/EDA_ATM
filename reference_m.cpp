#include <iostream>
#include <fstream>
using namespace std;

    int balances[] = {3000, 8000, 12000};
    unsigned short cards[] = {0, 1, 2};
    unsigned short passwords[] = {0, 1, 2};
    enum language
    {
        English,
        Arabic
    };
    enum op
    {
        Deposit,
        Withdraw,
        BalanceService,
        Cardoutop
    };


 void checkCard(unsigned short cardid, unsigned short &found, int &balance)
    {
        for (int i = 0; i < 3; i++)
        {
            if (cardid == cards[i])
            {
                balance = balances[cardid];
                found = 1;
            }
        }
    }
    unsigned short checkBalance(unsigned int amount, unsigned short cardid)
    {
        int diff = balances[cardid] - amount;
        if (diff < 0)
            return 0;
        else
            return 1;
    }
    unsigned short checkPass(unsigned short userpass, unsigned short realpass,unsigned short confirm)
    {
        if (confirm)
        {
            if (userpass == realpass)
                return 1;
            else
                return 0;
        }

        else
        {
            cout << "please press confirm" << endl;
            return 0;
        }
    }
    int deposit(unsigned short amount, unsigned short id, unsigned short confirm)
    {
        if (confirm)
        {
             balances[id] = balances[id] + amount;
            return balances[id];
        }
        else
        {
            cout << "please press confirm" << endl;
            return 0;
        }
    }
    int withdraw(unsigned short amount, unsigned short id, unsigned short confirm)
    {
        if (!confirm)
        {
            cout << "please press confirm" << endl;
            return 0;
        }
        unsigned short flag = checkBalance(amount, id);
        if (flag)
        {
            balances[id] = balances[id] - amount;
            return balances[id];
        }
        return 0;
    }

    int atm(unsigned short reset, unsigned short language,unsigned short card_in ,unsigned short confirm_d, unsigned short confirm_withd, unsigned short confirm_lang,unsigned short confirm_pass, unsigned short cardid, unsigned short password, unsigned short operation, unsigned short depositValue, unsigned short withdrawValue,unsigned short& card_out)
    {
        int balance = 0;
        unsigned short cardFound = 0, rightpassword = 0, time_out = 0, counter = 0;
        if(card_in){
            checkCard(cardid, cardFound, balance);
            if (reset == 0)
            {
                if (cardFound)
                {
                    rightpassword = checkPass(password, passwords[cardid],confirm_pass);
                }
                else
                {
                    cout << "card not found" << endl;
                    card_out=1;
                    return 0;
                }
                if (rightpassword)
                {
                    if (language == Arabic && confirm_lang)
                    {
                        cout << "you selected Arabic language" << endl;
                    }
                    else if (language == English && confirm_lang)
                    {
                        cout << "you selected English language" << endl;
                    }
                    else if (!confirm_lang)
                    {
                        cout << "please press confirm" << endl;
                    }
                    
                    switch (operation)
                    {
                    case Deposit:
                        balance= deposit(depositValue, cardid, confirm_d);
                        card_out=1;
                        cout << "balance=" << balance << endl;
                        break;
                    case Withdraw:
                        balance = withdraw(withdrawValue, cardid, confirm_withd);
                        card_out=1;
                        cout << "balance=" << balance << endl;
                        break;
                    case BalanceService:
                        cout << "balance=" << balance << endl;
                        card_out=1;
                        break;
                    case Cardoutop:
                        card_out=1;
                        return balance;
                        break;
                    default:
                        cout << "please enter a valid operation" << endl;
                        cout << "exiting system..." << endl;
                        card_out=1;
                        return balance;
                    }
                    return balance;
                }
                else
                {
                    cout << "sorry, you have entered a wrong password" << endl;
                    cout << "exiting system..." << endl;
                    card_out=1;
                    return 0;
                }
            }
            else
            {
                cout << "reset flag enabled" << endl;
                return 0;
            }
        }
        else{
            cout <<"No card entered"<<endl;
            return 0;
        }
    }




    int main(){

    std::ofstream outfile("output_ref.txt",std::ios_base::app);

    if (!outfile) {
        std::cerr << "Unable to open file";
        return 1;
    }

        int balance;

        unsigned short reset =0;
        unsigned short confirm_d=1;
        unsigned short confirm_withd=0;
        unsigned short confirm_lang=1;
        unsigned short confirm_pass=1;
        unsigned short card_in=1;
        unsigned short cardid=0;
        unsigned short password=0;
        unsigned short language=1;
        unsigned short operation1=Deposit;
    //  unsigned short operation2=Withdraw;
    //  unsigned short operation3=Deposit;
        unsigned short depositValue=256;
        unsigned short withdrawValue=0;
        unsigned short card_out=0;

        outfile << "balance= " << balances[cardid] << std::endl;
        balance=atm(reset,language,card_in,confirm_d,confirm_withd,confirm_lang,confirm_pass,cardid,password,operation1,depositValue,withdrawValue,card_out);

        // Multiple Operations

        // outfile << "balance= " << balance << std::endl;
        // balance=atm(reset,language,card_in,0,1,confirm_lang,confirm_pass,cardid,password,operation2,depositValue,withdrawValue,card_out);
        // outfile << "balance= " << balance << std::endl;
        // balance=atm(reset,language,card_in,1,0,confirm_lang,confirm_pass,cardid,password,operation3,depositValue,withdrawValue,card_out);

        cout <<"Card_out= " << card_out << endl;

        outfile << "balance= " << balance << std::endl;
    }