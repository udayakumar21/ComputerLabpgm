tcl file

set ns [new Simulator]
set tracefile [open "out.tr" w]
$ns trace-all $tracefile
set namfile [open "out.nam" w]
$ns namtrace-all $namfile

set n0 [$ns node] set n1 [$ns node] set n2 [$ns node] set n3 [$ns node]

$ns duplex-link $n0 $n1 10Mb 2ms DropTail
$ns duplex-link $n1 $n2 10Mb 2ms DropTail
$ns duplex-link $n2 $n3 10Mb 2ms DropTail


$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 10


set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set tcp3 [new Agent/TCP]
$ns attach-agent $n2 $tcp3
 
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

proc finish { } {
global ns tracefile namfile
$ns flush-trace close $tracefile close $namfile
exec nam out.nam & exit
}

$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"
$ns at 1.0 "$ftp3 start"
$ns at 1.0 "$cbr start"
$ns at 2.0 "finish"
$ns run



awk file

AWK File BEGIN {C=0
d=0} {
if($1=="r" && $5=="tcp") C++;
if($1=="r" && $5=="cbr") d++;
}
END {printf("number of pkt sent=%d\n",C); printf("number of pkt sent=%d\n",d);}
