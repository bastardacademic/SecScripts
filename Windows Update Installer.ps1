# Function to install Windows updates on a remote computer
function Install-WindowsUpdates {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Install updates on the remote computer
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Install-WindowsUpdate -AcceptAll -AutoReboot
        }
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
    }
}

# Example usage:
# Install-WindowsUpdates -ComputerName "Server1"
