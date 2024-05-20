# Function to monitor user logins
function Get-UserLogins {
    param (
        [string]$Username,
        [datetime]$StartDate = (Get-Date).AddDays(-7),
        [datetime]$EndDate = (Get-Date)
    )

    # Query the security event log for login events
    Get-EventLog -LogName Security -After $StartDate -Before $EndDate | Where-Object {
        $_.EventID -eq 4624 -and $_.ReplacementStrings[5] -eq $Username
    } | Select-Object TimeGenerated, @{Name="User";Expression={$_.ReplacementStrings[5]}}, @{Name="Computer";Expression={$_.ReplacementStrings[18]}}
}

# Example usage:
# Get-UserLogins -Username "jdoe" -StartDate (Get-Date).AddDays(-30) -EndDate (Get-Date)
