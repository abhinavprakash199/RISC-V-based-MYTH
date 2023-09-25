#include<stdio.h>
#include<math.h>

int main()
{
    unsigned long long int max1 = (unsigned long long int)(pow(2,64)-1); //Line 1
    unsigned long long int max2 = (unsigned long long int)(pow(2,127)-1);// Line 2
    unsigned long long int max3 = (unsigned long long int)(pow(2,64)*-1);// Line 3
    unsigned long long int max4 = (unsigned long long int)(pow(-2,64)-1);// Line 4
    unsigned long long int max5 = (unsigned long long int)(pow(-2,63)-1);// Line 5
    unsigned long long int max6 = (unsigned long long int)(pow(2,10)-1);// Line 6
    printf("Highest number represented by unsigned long long  int in (2^64)-1 is %llu \n",max1);
    printf("Highest number represented by unsigned long long  int in (2^127)-1 is %llu \n",max2);
    printf("Highest number represented by unsigned long long  int in (2^64)x(-1) is %llu \n",max3);
    printf("Highest number represented by unsigned long long  int in (-2^64)-1 is %llu \n",max4);
    printf("Highest number represented by unsigned long long  int in (-2^63)-1 is %llu \n",max5);
    printf("Highest number represented by unsigned long long  int in (2^10)-1 is %llu \n",max6);
    
    return 0;
}
