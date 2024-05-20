# Function to check disk usage on multiple servers
function Check-DiskUsage {
    param (
        [string[]]$Servers
    )

    foreach ($server in $Servers) {
        if (Test-Connection -ComputerName $server -Count 1 -Quiet) {
            $diskUsage = Invoke-Command -ComputerName $server -ScriptBlock {
                Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used(GB)";Expression={[math]::round($_.Used/1GB, 2)}}, @{Name="Free(GB)";Expression={[math]::round($_.Free/1GB, 2)}}
            }
            Write-Host "Disk usage for $server:"
            $diskUsage | Format-Table -AutoSize
        } else {
            Write-Warning "$server is not reachable."
        }
    }
}

# Example usage
$servers = @("Server1", "Server2", "Server3")
Check-DiskUsage -Servers $servers
