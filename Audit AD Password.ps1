# Import DSInternals module
Import-Module DSInternals

# Function to audit AD passwords
function Audit-ADPasswords {
    param (
        [string]$DomainController,
        [string]$PasswordListPath
    )

    # Ensure the password file exists
    if (-not (Test-Path $PasswordListPath)) {
        Write-Error "Password list file does not exist at the path: $PasswordListPath"
        return
    }

    # Read passwords from the file
    $commonPasswords = Get-Content $PasswordListPath

    # Fetch domain information
    $domain = Get-ADDomain -Server $DomainController

    # Test each password against all users in the domain
    foreach ($password in $commonPasswords) {
        Write-Host "Testing password: $password"
        Get-ADReplAccount -All -Server $DomainController | Test-PasswordQuality -WeakPasswordHashes (ConvertTo-NTHash $password) -SkipExpired -SkipDisabledAccounts | Format-Table AccountName, WeakPassword
    }
}

# Example usage:
# Audit-ADPasswords -DomainController "YourDC" -PasswordListPath "C:\path\to\commonpasswords.txt"
