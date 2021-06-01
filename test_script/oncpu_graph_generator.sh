#!/bin/zsh

cd ~/ros2_foxy_analysis/test_script

PID=`ps aux | grep pubsub/listener | head -1 | awk '{print $2}'`

cat /proc/$PID/maps > listener-map.txt

sudo perf record -F 999 -g -p $PID --call-graph dwarf -- sleep 30

sudo perf script > stack.txt 

sudo cat stack.txt | ../../FlameGraph/stackcollapse-perf.pl > out.perf-folded
sudo ../../FlameGraph/flamegraph.pl out.perf-folded > subscriber_stack_trace.svg

#rm -rf perf.data stack.txt out.perf-folded



