CLIENT

#include<stdio.h> #include<sys/types.h>
#include<fcntl.h> #include<sys/un.h> 
#include<sys/socket.h> 
#include<sys/ipc.h>
int main()
{
int sid,newsid,n;
char buf[2000],fn[50]; struct sockaddr_un ser,cli;
printf("enter the file name\n"); scanf("%s",buf); sid=socket(AF_UNIX,SOCK_STREAM,0); ser.sun_family=AF_UNIX; strcpy(ser.sun_path,"SOCKET");
n=connect(sid,(struct sockaddr*)&ser,sizeof(ser)); write(sid,buf,sizeof(buf)); n=read(sid,buf,sizeof(buf));
printf("contet of file are:\n"); printf("%s",buf);
close(sid); unlink("socket");
}
 

RECIEVER / SERVER

#include<stdio.h> #include<sys/types.h> #include<fcntl.h> #include<sys/un.h> #include<sys/socket.h> #include<sys/ipc.h>
int main()
{
int sid,newsid,len,fd,n; char buf[2000],fn[50]; struct sockaddr_un ser,cli;
sid=socket(AF_UNIX,SOCK_STREAM,0); ser.sun_family=AF_UNIX; strcpy(ser.sun_path,"SOCKET"); n=bind(sid,(struct sockaddr*)&ser,sizeof(ser)); listen(sid,5);
len=sizeof(cli);
newsid=accept(sid,(struct sockaddr*)&cli,&len); read(newsid,buf,sizeof(buf)); fd=open(buf,O_RDONLY); n=read(fd,buf,2000);
write(newsid,buf,n); close(sid); close(newsid); unlink("SOCKET");
}
output

client
cat > Udaya
mr robot
server side
./a.out
