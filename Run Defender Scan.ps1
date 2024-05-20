# Function to scan and remove malware from systems
function Scan-And-RemoveMalware {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Scan and remove malware using Windows Defender
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Start-MpScan -ScanType FullScan
            Remove-MpThreat -All
        }
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
    }
}

# Example usage:
# Scan-And-RemoveMalware -ComputerName "Server1"
