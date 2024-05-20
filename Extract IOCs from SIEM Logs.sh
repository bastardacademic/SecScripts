#!/bin/bash

# Function to extract IOCs from SIEM logs
function extract_iocs {
    siem_log_file="/var/log/siem.log"
    ioc_file="/var/log/iocs.txt"

    grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$siem_log_file" | sort | uniq > "$ioc_file"
    grep -oE '[a-f0-9]{32,}' "$siem_log_file" | sort | uniq >> "$ioc_file"

    echo "IOCs extracted to $ioc_file"
}

# Example usage
extract_iocs
