# Function to scan open ports on a target IP
function Scan-OpenPorts {
    param (
        [string]$TargetIP,
        [int[]]$Ports = @(22, 80, 443, 3389)
    )

    # Scan each port on the target IP
    foreach ($port in $Ports) {
        $tcpConnection = Test-NetConnection -ComputerName $TargetIP -Port $port
        if ($tcpConnection.TcpTestSucceeded) {
            Write-Host "Port $port is open on $TargetIP"
        } else {
            Write-Host "Port $port is closed on $TargetIP"
        }
    }
}

# Example usage:
# Scan-OpenPorts -TargetIP "192.168.1.1" -Ports @(22, 80, 443)
