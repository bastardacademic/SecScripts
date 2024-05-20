#!/bin/bash

# Function to detect suspicious processes
function detect_suspicious_processes {
    log_file="/var/log/suspicious_processes.log"
    ps aux | grep -iE "nc|netcat|nmap|hydra|john" > "$log_file"

    echo "Suspicious processes logged in $log_file"
}

# Example usage
detect_suspicious_processes
