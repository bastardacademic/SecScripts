# Function to delete an AD user account
function Remove-ADUserAccount {
    param (
        [string]$Username
    )

    # Remove the AD user
    Remove-ADUser -Identity $Username -Confirm:$false
}

# Example usage:
# Remove-ADUserAccount -Username "jdoe"
