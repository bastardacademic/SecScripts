# Function to review access control settings and permissions
function Review-AccessControl {
    param (
        [string]$DomainController
    )

    # Review permissions for each user in the domain
    $users = Get-ADUser -Filter * -Server $DomainController
    foreach ($user in $users) {
        $userPermissions = Get-ACL -Path ("AD:\" + $user.DistinguishedName) | Select-Object -ExpandProperty Access
        Write-Host "Permissions for user $($user.SamAccountName):"
        $userPermissions | ForEach-Object {
            Write-Host $_.IdentityReference, $_.AccessControlType, $_.ActiveDirectoryRights
        }
    }
}

# Example usage:
# Review-AccessControl -DomainController "YourDC"
