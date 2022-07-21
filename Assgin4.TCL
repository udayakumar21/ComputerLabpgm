tcl-file

set ns [new Simulator] set tr [open "out.tr" w]
$ns trace-all $tr
set ntr [open "out.nam" w]
$ns namtrace-all $ntr set n0 [$ns node]
set n1 [$ns node] set n2 [$ns node] set n3 [$ns node] set n4 [$ns node] set n5 [$ns node]

$ns duplex-link $n0 $n4 10Mb 4ms DropTail
$ns duplex-link $n1 $n4 20Mb 5ms DropTail
$ns duplex-link $n2 $n4 30Mb 6ms DropTail
$ns duplex-link $n3 $n4 40Mb 7ms DropTail
$ns duplex-link $n4 $n5 50Mb 8ms DropTail

set p1 [new Agent/Ping]
$ns attach-agent $n0 $p1 set p2 [new Agent/Ping]
$ns attach-agent $n1 $p2 set p3 [new Agent/Ping]
$ns attach-agent $n2 $p3 set p4 [new Agent/Ping]
$ns attach-agent $n3 $p4 set p5 [new Agent/Ping]
$ns attach-agent $n4 $p5

$ns queue-limit $n0 $n4 5
$ns queue-limit $n2 $n4 3
$ns queue-limit $n4 $n5 2 Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] Received Ping message from $from with rtt value $rtt";
}
$ns connect $p1 $p5
$ns connect $p3 $p4 proc finish { } { global ns tr ntr
$ns flush-trace close $tr
close $ntr
 
exec nam out.nam & exit 0
}
$ns at 0.1 "$p1 send"
$ns at 0.2 "$p1 send"
$ns at 0.3 "$p1 send"
$ns at 0.4 "$p1 send"
$ns at 0.5 "$p1 send"
$ns at 0.6 "$p1 send"
$ns at 0.7 "$p1 send"
$ns at 0.8 "$p1 send"
$ns at 0.9 "$p1 send"
$ns at 1.0 "$p1 send"
$ns at 0.1 "$p3 send"
$ns at 0.2 "$p3 send"
$ns at 0.3 "$p3 send"
$ns at 0.2 "$p3 send"
$ns at 0.4 "$p3 send"
$ns at 0.5 "$p3 send"
$ns at 0.6 "$p3 send"
$ns at 0.7 "$p3 send"
$ns at 0.8 "$p3 send"
$ns at 0.9 "$p3 send"
$ns at 1.0 "$p3 send"
$ns at 2.0 "finish"
$ns run



awk-file

BEGIN {c=0} {
if($1=="d") c++;
}
END {printf("no of packets dropped=%d",c);}
