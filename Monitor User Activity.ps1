# Function to monitor user activity
function Monitor-UserActivity {
    param (
        [string]$Username,
        [datetime]$StartDate = (Get-Date).AddDays(-7),
        [datetime]$EndDate = (Get-Date)
    )

    # Query the security event log for user logon events
    Get-WinEvent -LogName Security -FilterHashtable @{
        StartTime = $StartDate
        EndTime = $EndDate
        Id = 4624
    } | Where-Object {
        $_.Properties[5].Value -eq $Username
    } | Select-Object TimeCreated, @{Name="User";Expression={$_.Properties[5].Value}}, @{Name="Computer";Expression={$_.Properties[18].Value}}
}

# Example usage
$userLogins = Monitor-UserActivity -Username "jdoe"
$userLogins | Format-Table -Property TimeCreated, User, Computer
