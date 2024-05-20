# Import Active Directory module
Import-Module ActiveDirectory

# Function to check for privileged accounts
function Check-PrivilegeEscalation {
    param (
        [string]$DomainController
    )

    # Define admin groups to check
    $adminGroups = @("Domain Admins", "Enterprise Admins")

    # Check each group for members
    foreach ($group in $adminGroups) {
        $members = Get-ADGroupMember -Identity $group -Server $DomainController
        Write-Host "$group members:"
        $members | ForEach-Object {
            Write-Host $_.SamAccountName
        }
    }
}

# Example usage:
# Check-PrivilegeEscalation -DomainController "YourDC"
