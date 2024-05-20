# Function to collect forensic data from a remote computer
function Collect-ForensicData {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Collect data from the remote computer
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            $sysInfo = Get-ComputerInfo
            $eventLogs = Get-EventLog -LogName System -Newest 100
            $installedApps = Get-WmiObject -Class Win32_Product | Select-Object Name, Version

            $data = @{
                SystemInfo = $sysInfo
                EventLogs = $eventLogs
                InstalledApps = $installedApps
            }

            return $data
        } | Export-Clixml -Path "C:\Forensics\$ComputerName.xml"
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
    }
}

# Example usage:
# Collect-ForensicData -ComputerName "VictimPC"
