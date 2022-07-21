CRC-SENDER

#include<stdio.h> int main()
{
int i, j, dw[24],cw[24];
int p[17]={1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1};
printf("Enter the 8 bit data\n"); for(i=0;i<8;i++) scanf("%d",&dw[i]); for(i=0;i<8;i++)
cw[i]=dw[i]; for(i=8;i<24;i++) cw[i]=0;

for(i=0;i<8;i++)
{
if(cw[i]==1)
{
for(j=0;j<17;j++)
{
cw[i+j]=cw[i+j]^p[j];
}
}
}
printf("codeword"); for(i=0;i<8;i++) printf("%d",dw[i]); for(i=8;i<24;i++) printf("%d",cw[i]); return 0;
}
 


CRC-RECIEVER

#include<stdio.h> #include<stdlib.h> int main()
{
int i, j, dw[24],cw[24],flag;
int p[17]={1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1};
printf("Enter the code word\n"); for(i=0;i<24;i++) scanf("%d",&cw[i]); for(i=0;i<24;i++)
dw[i]=cw[i];

for(i=0;i<8;i++)
{
if(cw[i]==1)
{
for(j=0;j<17;j++)
{
cw[i+j]=cw[i+j]^p[j];
}
}
}

for(i=0;i<24;i++)
{
if(cw[i]!=0)
{
printf("Error occured\n"); flag=1;
exit(0);
}
else flag=0;
}
if(flag==0)
{
printf("Data is error free\n"); for(i=0;i<8;i++)
printf("%d",dw[i]);
}
return 0;
}
