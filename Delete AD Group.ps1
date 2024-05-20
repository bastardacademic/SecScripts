# Function to delete an AD group
function Remove-ADGroup {
    param (
        [string]$GroupName
    )

    # Remove the AD group
    Remove-ADGroup -Identity $GroupName -Confirm:$false
}

# Example usage:
# Remove-ADGroup -GroupName "ITAdmins"
