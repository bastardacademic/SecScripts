# Function to monitor and alert on data exfiltration
function Monitor-DataExfiltration {
    param (
        [string]$LogFile = "C:\ExfiltrationLog.txt"
    )

    # Monitor data exfiltration
    Get-WinEvent -LogName "Security" | Where-Object {
        $_.Id -eq 4663 -and $_.Properties[0].Value -match "WriteData"
    } | ForEach-Object {
        Add-Content -Path $LogFile -Value "Potential data exfiltration detected: $($_.Message)"
    }

    Write-Host "Monitoring data exfiltration. Log file: $LogFile"
}

# Example usage:
# Monitor-DataExfiltration -LogFile "C:\ExfiltrationLog.txt"
