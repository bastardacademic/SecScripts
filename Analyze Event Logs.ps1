# Function to analyze event logs for suspicious activity
function Analyze-EventLogs {
    param (
        [string]$ComputerName,
        [string]$LogName = "Security",
        [int]$Newest = 100
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Get event logs from the remote computer
        $logs = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-EventLog -LogName $using:LogName -Newest $using:Newest
        }
        return $logs
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
        return $null
    }
}

# Example usage:
# $logs = Analyze-EventLogs -ComputerName "Server1" -LogName "Security" -Newest 100
# $logs | Format-Table -Property EventID, Source, Message
