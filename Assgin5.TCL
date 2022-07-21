tcl-file

set ns [new Simulator]
set tracefile [open "out.tr" w]
$ns trace-all $tracefile
set namfile [open "out.nam" w]
$ns namtrace-all $namfile

set n0 [$ns node] set n1 [$ns node] set n2 [$ns node] set n3 [$ns node] set n4 [$ns node] set n5 [$ns node]

$ns duplex-link $n0 $n1 15Mb 4ms DropTail
$ns duplex-link $n1 $n2 5Mb 3ms DropTail
set Lan [$ns newLan "$n1 $n3 $n4 $n5" 3Mb 1ms LL Queue/DropTail Mac/Csma/Cd channel] set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp

proc finish {} {
global ns tracefile namfile
$ns flush-trace close $tracefile close $namfile
exec nam out.nam & exit 0
}
$ns at 1.0 "$ftp start"
$ns at 5.0 "$ftp stop"
$ns at 10.0 "finish"
$ns run
 
awk-file

BEGIN{ c=0; ftppktsize=0; ftpthrough=o}{ if($1=="r"&&$5=="tcp"&&$4="0"&&$3="3") c++;
$6=ftppktsize;
}
END{ ftpthroghput = c+ftppktsize/10; printf("throughput is=%d", ftpthroughput);
}
