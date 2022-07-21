#include<stdio.h> #include<stdlib.h> struct node{
int dest[20]; int from[20];
}rt[10];
int main()
{
int c[20][20],arr[20];
int d,i,j,k,n,s,ct=0;
printf("enter the no of nodes\n"); scanf("%d",&n);
printf("enter the cost matrix\n"); for(i=0;i<n;i++) for(j=0;j<n;j++)
{
scanf("%d",&c[i][j]);
rt[i].dest[j]=c[i][j]; rt[i].from[j]=j;
}
printf("enter the source node\n"); scanf("%d",&s);
printf("enter destination node\n"); scanf("%d",&d);
for(i=0;i<n;i++)
{
printf("routing table info of %d route\n",i+1); printf("source\t destination\t via\t cost\n"); for(j=0;j<n;j++)
printf("%d\t %d\t %d\t %d\n",i,j,rt[i].from[j],rt[i].dest[j]);
}
do
{
ct=0; for(i=0;i<n;i++) for(j=0;j<n;j++) for(k=0;k<n;k++)
if(rt[i].dest[j]>c[i][k]+rt[k].dest[j])
{
 



}
}while(ct!=0);
 
rt[i].dest[j]=rt[i].dest[k]+rt[k].dest[j]; rt[i].from[j]=k;
ct++;
 
printf("after updating\n"); for(i=0;i<n;i++)
{
printf("routing table of %d route\n",i+1); printf("source\t destination\t via\t cost\n"); for(j=0;j<n;j++) printf("%d\t%d\t%d\t%d\n",i,j,rt[i].from[j],rt[i].dest[j]);
}
printf("the minimum cost from %d to %d is %d\n",s,d,rt[s].dest[d]); printf("the shortest path from %d to %d\n",s,d);
arr[0]=s; i=1;
while(s!=d)
{
arr[i++]=rt[s].from[d];
s=rt[s].from[d];
}
for(j=0;j<i-1;j++) printf("%d	>",arr[j]);
printf("%d\n",arr[j]); return 0;
}

3
0 9 2 999 6 999 999 3 0 
  0 
  1
 
