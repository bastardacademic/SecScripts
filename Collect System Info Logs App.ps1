# Function to collect system information
function Collect-SystemInfo {
    $sysInfo = Get-ComputerInfo
    $eventLogs = Get-EventLog -LogName System -Newest 100
    $installedApps = Get-WmiObject -Class Win32_Product | Select-Object Name, Version

    return @{
        SystemInfo = $sysInfo
        EventLogs = $eventLogs
        InstalledApps = $installedApps
    }
}

# Example usage
$info = Collect-SystemInfo
$info | Format-List
