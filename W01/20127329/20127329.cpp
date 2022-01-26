#include<iostream>
using namespace std;
void convert_Number_To_Binary(char Arr[16],short x)
{
    for (short i = 15; i >=0; i--)
    {
        Arr[i] = ((x & 1)+'0');
        x >>= 1;  
    }
    cout << " A (Binary):";
    for (short i = 0; i <=15; i++)
    {
        cout << Arr[i] << " ";
    }
}
void addBinary(char Arr[16])
{

    char b[16] = { '0', '0' ,'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0' ,'1' };
    short apos = 15;
    short bpos = 15;
    short adigit, bdigit, carry = 0;
    short i = 15;
    while (apos >= 0 || bpos >= 0 || carry == 1)
    {
        adigit = bdigit = 0;

        if (apos >= 0)
            adigit = Arr[apos--] == '1';
        if (bpos >= 0) 
           bdigit = b[bpos--] == '1';
        Arr[i] = static_cast<char>(adigit ^ bdigit ^ carry + '0');
        carry = adigit + bdigit + carry >= 2;
        i--;
        if (i == -1) break;
    }

}
void convert_Number_To_Sub_Binary(char Arr[16], short x)
{
    
    for (short i = 0; i <=15; i++)
    {

        Arr[i] = (Arr[i] - '0') ^ 1 + '0';

    }
    addBinary(Arr);
    cout << "-A (Binary):";
       for (short i = 0; i <=15; i++)
       {

        cout << Arr[i] << " ";
       }
   
}
void convert_To_Decimal(char Arr[16])
{
    cout << endl;
    short result = 0;
    cout << "-A (Decimal): ";
    for (short i = 0; i<=15; i++)
    {
        result = (result<<1)+short(Arr[i] - '0');
        
    }
    cout << result << endl;
   
}


int main()
{
	short x;
    char Arr[16];
    cout << "Hay nhap so  x:" << endl;
    cin >> x;
    convert_Number_To_Binary(Arr, x);
    cout << endl;
    convert_Number_To_Sub_Binary(Arr, x);
    cout << endl;
    convert_To_Decimal(Arr);

 
   

	return 1;
}
