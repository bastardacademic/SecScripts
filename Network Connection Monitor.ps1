# Function to monitor network connections
function Get-NetworkConnections {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Get network connections from the remote computer
        $connections = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
        }
        return $connections
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
        return $null
    }
}

# Example usage:
# $connections = Get-NetworkConnections -ComputerName "Server1"
# $connections | Format-Table -Property LocalAddress, LocalPort, RemoteAddress, RemotePort, State
