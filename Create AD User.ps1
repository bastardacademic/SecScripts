# Import Active Directory module
Import-Module ActiveDirectory

# Function to create a new AD user account
function New-ADUserAccount {
    param (
        [string]$Username,
        [string]$Password,
        [string]$FirstName,
        [string]$LastName,
        [string]$OU = "OU=Users,DC=YourDomain,DC=com"
    )

    # Create a new AD user
    New-ADUser -Name $Username `
               -GivenName $FirstName `
               -Surname $LastName `
               -UserPrincipalName "$Username@yourdomain.com" `
               -SamAccountName $Username `
               -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
               -Enabled $true `
               -Path $OU `
               -PasswordNeverExpires $true
}

# Example usage:
# New-ADUserAccount -Username "jdoe" -Password "P@ssw0rd!" -FirstName "John" -LastName "Doe"
