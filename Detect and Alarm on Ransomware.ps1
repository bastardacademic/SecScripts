# Function to detect and alert on ransomware activity
function Detect-RansomwareActivity {
    param (
        [string]$LogFile = "C:\RansomwareLog.txt"
    )

    # Monitor for ransomware-related events
    Get-WinEvent -LogName "Security" | Where-Object {
        $_.Id -eq 4663 -and $_.Properties[0].Value -match "Encrypt"
    } | ForEach-Object {
        Add-Content -Path $LogFile -Value "Potential ransomware activity detected: $($_.Message)"
    }

    Write-Host "Monitoring ransomware activity. Log file: $LogFile"
}

# Example usage:
# Detect-RansomwareActivity -LogFile "C:\RansomwareLog.txt"
