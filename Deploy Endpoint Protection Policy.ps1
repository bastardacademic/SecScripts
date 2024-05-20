# Function to deploy endpoint protection policies
function Deploy-EndpointProtection {
    param (
        [string]$ComputerName,
        [string]$PolicyPath
    )

    # Check if the computer is online
    if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
        # Deploy the endpoint protection policy
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Import-Csv -Path $using:PolicyPath | ForEach-Object {
                Set-MpPreference -ThreatDefaultAction_AdditionalAction $_.Action
            }
        }
        Write-Host "Endpoint protection policy deployed to $ComputerName."
    } else {
        Write-Warning "Computer $ComputerName is not reachable."
    }
}

# Example usage:
# Deploy-EndpointProtection -ComputerName "Server1" -PolicyPath "C:\Policies\EndpointProtection.csv"
