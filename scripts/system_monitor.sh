#!/bin/bash

# Log file location
log_file="/var/log/system_monitor.log"

# Interval for monitoring (in seconds)
interval=60

echo "Starting System Performance Monitoring. Logs will be saved to $log_file."
echo "Monitoring interval: $interval seconds."

# Create log file with headers
echo "Timestamp           CPU Usage   Memory Usage" > $log_file

# Infinite loop to monitor system performance
while true; do
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  
  # Get CPU usage in percentage
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
  
  # Get memory usage
  mem_usage=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
  
  # Log the data   
#
  echo "$timestamp   $cpu_usage   $mem_usage" >> $log_file
  
  # Wait for the specified interval
  sleep $interval
done
