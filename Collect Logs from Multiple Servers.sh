#!/bin/bash

# Function to collect logs from multiple servers
function collect_logs {
    servers=("server1.example.com" "server2.example.com" "server3.example.com")
    log_file="/var/log/syslog"
    dest_dir="/var/log/collected_logs"

    mkdir -p "$dest_dir"
    for server in "${servers[@]}"; do
        scp "user@$server:$log_file" "$dest_dir/$server-syslog"
    done
}

# Example usage
collect_logs

