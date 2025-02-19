#!/bin/bash

# Iterate through the range of IP addresses
for i in $(seq 2 254); do
    # Extract the specific log lines for the current IP address
    grep -A 61 -w "ted to 172.16.16.$i" iperf_results-300-nodes-10M.log|  tail -n 60 |awk '{print $7}' > 172.16.16.$i.log
done
