# Function to modify an AD group
function Modify-ADGroup {
    param (
        [string]$GroupName,
        [string]$NewDescription
    )

    # Modify the AD group
    Set-ADGroup -Identity $GroupName -Description $NewDescription
}

# Example usage:
# Modify-ADGroup -GroupName "ITAdmins" -NewDescription "Updated IT Administrators Group"
