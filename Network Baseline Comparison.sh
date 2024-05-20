#!/bin/bash

# Function to capture the current network baseline
function capture_baseline {
    baseline_file="/var/log/network_baseline.txt"
    netstat -tuln > "$baseline_file"
    echo "Network baseline captured in $baseline_file"
}

# Function to compare the current network state against the baseline
function compare_baseline {
    baseline_file="/var/log/network_baseline.txt"
    current_file="/var/log/current_network.txt"
    netstat -tuln > "$current_file"

    echo "Comparing current network state to baseline..."
    diff "$baseline_file" "$current_file"
}

# Example usage
capture_baseline
compare_baseline
