tcl file

set ns [new Simulator]
set tracefile [open "out.tr" w]
$ns trace-all $tracefile
set namfile [open "out.nam" w]
$ns namtrace-all $namfile

set n0 [$ns node] set n1 [$ns node] set n2 [$ns node] set n3 [$ns node]

$ns color 1 Red
$ns color 2 Blue

$ns duplex-link $n0 $n2 10Mb 3ms DropTail
$ns duplex-link $n1 $n2 10Mb 3ms DropTail
$ns duplex-link $n2 $n3 10Mb 3ms DropTail

#$ns queue-limit $n0 $n1 10 #$ns queue-limit $n1 $n2 10 #$ns queue-limit $n2 $n3 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0


set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
set telnet0 [new Application/Telnet]
$telnet0 attach-agent $tcp1


proc finish { } {
global ns tracefile namfile
$ns flush-trace close $tracefile
 
close $namfile
exec nam out.nam & exit 0
}

$ns at 0.1 "$ftp0 start"
$ns at 0.1 "$telnet0 start"

$ns at 10.0 "finish"
$ns run


awk file

BEGIN{c=0;telnetpktsize=0;telnetthroughput=0;d=0;ftppktsize=0;ftpthroughput=0;
}
{
if($1=="r" && $5=="tcp" && $3=="1" && $4=="3") c++;
ftppktsize=$6;
if($1=="r" && $5=="tcp" && $3=="0" && $4=="3") d++;
telnetpktsize=$6;
}

END{ ftpthroughput=((c)(ftppktsize)(8))/10; telnetthroughput=((d)(telnetpktsize)(8))/10;
printf("throughput is = %d,\n%d",ftpthroughput,telnetthroughput);
}
