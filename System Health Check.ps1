# Function to check system health (CPU, memory, disk usage)
function Check-SystemHealth {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Get system health information from the remote computer
        $healthInfo = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            $cpu = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
            $memory = Get-WmiObject Win32_OperatingSystem | Select-Object @{Name="Total";Expression={[math]::round($_.TotalVisibleMemorySize/1MB,2)}},@{Name="Free";Expression={[math]::round($_.FreePhysicalMemory/1MB,2)}}
            $disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, @{Name="Size(GB)";Expression={[math]::round($_.Size/1GB,2)}}, @{Name="FreeSpace(GB)";Expression={[math]::round($_.FreeSpace/1GB,2)}}

            return @{
                CPU = "$cpu%"
                Memory = "Total: $($memory.Total)GB, Free: $($memory.Free)GB"
                Disk = $disk
            }
        }
        return $healthInfo
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
        return $null
    }
}

# Example usage:
# $health = Check-SystemHealth -ComputerName "Server1"
# $health | Format-List
