#include<stdio.h>

extern int load(int x, int y);   //initialize the function to load value in a0 and a1 RISC-V registers
int main()
{
    int result = 0;
    int count = 9;
    result = load(0x0,count+1);  // receive the data in the a0 registers of RISC-V and read in c
    // a0 = load(a0,a1)
    printf("Sum of numbers from 1 to %d is %d\n",count,result);
    
}
