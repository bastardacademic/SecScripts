# Function to capture network traffic for incident response
function Capture-NetworkTraffic {
    param (
        [string]$ComputerName,
        [string]$CaptureFile = "C:\NetworkTraffic.pcap",
        [int]$DurationSeconds = 60
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Capture network traffic using Tshark (Wireshark command line tool)
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Start-Process -FilePath "tshark.exe" -ArgumentList "-a duration:$using:DurationSeconds -w $using:CaptureFile" -NoNewWindow -Wait
        }
        Write-Host "Network traffic captured on $ComputerName for $DurationSeconds seconds."
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
    }
}

# Example usage:
# Capture-NetworkTraffic -ComputerName "Server1" -CaptureFile "C:\NetworkTraffic.pcap" -DurationSeconds 60
