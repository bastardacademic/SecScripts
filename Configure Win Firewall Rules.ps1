# Function to configure Windows Firewall rules
function Configure-WindowsFirewall {
    param (
        [string]$RuleName,
        [string]$Direction = "Inbound",
        [string]$Action = "Allow",
        [string]$Protocol = "TCP",
        [string]$LocalPort = "Any",
        [string]$RemotePort = "Any",
        [string]$Profile = "Any"
    )

    # Add or update the firewall rule
    New-NetFirewallRule -DisplayName $RuleName `
                        -Direction $Direction `
                        -Action $Action `
                        -Protocol $Protocol `
                        -LocalPort $LocalPort `
                        -RemotePort $RemotePort `
                        -Profile $Profile
    Write-Host "Firewall rule $RuleName configured."
}

# Example usage:
# Configure-WindowsFirewall -RuleName "Allow HTTP" -Direction "Inbound" -Action "Allow" -Protocol "TCP" -LocalPort 80
