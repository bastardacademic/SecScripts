# Function to create a new AD group
function New-ADGroup {
    param (
        [string]$GroupName,
        [string]$Description,
        [string]$OU = "OU=Groups,DC=YourDomain,DC=com"
    )

    # Create a new AD group
    New-ADGroup -Name $GroupName `
                -GroupScope Global `
                -Description $Description `
                -Path $OU
}

# Example usage:
# New-ADGroup -GroupName "ITAdmins" -Description "IT Administrators Group"
