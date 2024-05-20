# Function to capture and analyze network traffic for anomalies
function Analyze-NetworkTraffic {
    param (
        [string]$ComputerName,
        [int]$CaptureDuration = 60
    )

    # Ensure PktMon is available
    if (-not (Get-Command PktMon -ErrorAction SilentlyContinue)) {
        Write-Error "PktMon is not available. Please ensure PktMon is installed."
        return
    }

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Capture network traffic for the specified duration
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Start-Process -FilePath "pktmon.exe" -ArgumentList "start --capture --file-name C:\TrafficCapture.etl"
            Start-Sleep -Seconds $using:CaptureDuration
            Start-Process -FilePath "pktmon.exe" -ArgumentList "stop"
            ConvertFrom-Etl -Path "C:\TrafficCapture.etl" -OutputFormat Text -OutputFileName "C:\TrafficCapture.txt"
        }

        # Analyze captured traffic
        $trafficData = Get-Content "\\$ComputerName\C$\TrafficCapture.txt"
        return $trafficData
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
        return $null
    }
}

# Example usage:
# $traffic = Analyze-NetworkTraffic -ComputerName "Server1" -CaptureDuration 60
# $traffic | Format-List
