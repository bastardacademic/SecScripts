# Function to review user accounts
function Review-UserAccounts {
    param (
        [string]$DomainController
    )

    $users = Get-ADUser -Filter * -Server $DomainController
    foreach ($user in $users) {
        $userDetails = Get-ADUser -Identity $user.SamAccountName -Properties LastLogonDate, Enabled, PasswordExpired
        Write-Host "User: $($user.SamAccountName)"
        Write-Host "  Last Logon: $($userDetails.LastLogonDate)"
        Write-Host "  Account Enabled: $($userDetails.Enabled)"
        Write-Host "  Password Expired: $($userDetails.PasswordExpired)"
    }
}

# Example usage
$domainController = "YourDC"
Review-UserAccounts -DomainController $domainController
