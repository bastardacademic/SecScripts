# Function to scan for missing security updates on a Windows system
function Scan-WindowsVulnerabilities {
    param (
        [string]$ComputerName
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Get missing updates from the remote computer
        $missingUpdates = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-WindowsUpdate -IsInstalled 0 | Where-Object { $_.Classification -eq "Security Updates" }
        }
        return $missingUpdates
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
        return $null
    }
}

# Example usage:
# $vulnerabilities = Scan-WindowsVulnerabilities -ComputerName "Server1"
# $vulnerabilities | Format-Table -Property Title, KBArticleID, Installed
