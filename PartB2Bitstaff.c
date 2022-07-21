#include<stdio.h> 
int main()
{
char n[50],stuff[50],destuff[50]; int p=0,q=0,c=0;
printf("enter the data\n"); scanf("%s",n);
while(n[p]!='\0')
{
if(n[p]=='0')
{
stuff[q]=n[p]; q++;
p++;
}
else
{
while(n[p]=='1' && c!=5)
{
c++;
stuff[q]=n[p]; q++;
p++;
}
if(c==5)
{
stuff[q]='0'; q++;
}
c=0;
}
}
stuff[q]='\0';
printf("stuff = %s\n",stuff);

p=0; q=0;
while(stuff[p]!='\0')
{
if(stuff[p]=='0')
{
destuff[q]=stuff[p]; q++;
p++;
}
 
else
{
while(stuff[p]=='1' &&c!=5)
{
c++;
destuff[q]=stuff[p]; q++;
p++;
}
if(c==5)
{
p++;
}
c=0;
}
}
destuff[p]='\0';
printf("destuff = %s\n",destuff);
  return 0;
}
