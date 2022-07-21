tcl file

set ns [new Simulator]
set tracefile [open "out.tr" w]
$ns trace-all $tracefile
set namfile [open "out.nam" w]
$ns namtrace-all $namfile

set n0 [$ns node] set n1 [$ns node] set n2 [$ns node]

$ns duplex-link $n0 $n1 10Mb 2ms DropTail
$ns duplex-link $n1 $n2 10Mb 2ms DropTail
$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 8

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp

proc finish { } {
global ns tracefile namfile
$ns flush-trace close $tracefile close $namfile
exec nam out.nam & exit
}

$ns at 1.0 "$cbr start"
 
$ns at 5.0 "$ftp start"
$ns at 10.0 "finish"
$ns run

awk file

BEGIN {c=0}
{
if ($1=="d") c++;
}
END {printf("no of packets dropped=%d",c);
}
