#include<stdio.h>
int main()
{
   int sum=0,n = 100,i;
   for(i=0;i<=n;i++){
	 sum +=i;}
   printf("Sum of numbers from 1 to %d is %d\n",n,sum);
   return 0;
}
