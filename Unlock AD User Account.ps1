# Function to unlock a locked AD user account
function Unlock-ADUserAccount {
    param (
        [string]$Username
    )

    # Unlock the AD user account
    Unlock-ADAccount -Identity $Username
}

# Example usage:
# Unlock-ADUserAccount -Username "jdoe"
