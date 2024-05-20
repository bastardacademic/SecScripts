# Function to disable a user account
function Disable-UserAccount {
    param (
        [string]$Username
    )

    Disable-ADAccount -Identity $Username
    Write-Host "User account $Username disabled."
}

# Example usage
Disable-UserAccount -Username "jdoe"
