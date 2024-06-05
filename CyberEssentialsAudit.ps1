# Import Active Directory module
Import-Module ActiveDirectory

# Function to get user information
function Get-UserInfo {
    param (
        [string]$UserName
    )

    # Get user details
    $user = Get-ADUser -Identity $UserName -Properties DisplayName, EmailAddress, LastLogonDate, PasswordLastSet, PasswordNeverExpires, AccountExpirationDate, LockedOut, Enabled, WhenCreated, UserPrincipalName

    if ($null -eq $user) {
        Write-Output "User $UserName not found."
        return
    }

    # Get group memberships
    $groups = Get-ADUser -Identity $UserName -Properties MemberOf | Select-Object -ExpandProperty MemberOf

    # Get group names
    $groupNames = @()
    foreach ($group in $groups) {
        $groupNames += (Get-ADGroup -Identity $group).Name
    }

    # Get effective permissions
    $acl = Get-Acl "AD:\$($user.DistinguishedName)"
    $permissions = $acl.Access | Select-Object IdentityReference, ActiveDirectoryRights, AccessControlType, IsInherited

    # Output user information
    [PSCustomObject]@{
        UserName              = $user.SamAccountName
        DisplayName           = $user.DisplayName
        EmailAddress          = $user.EmailAddress
        LastLogonDate         = $user.LastLogonDate
        PasswordLastSet       = $user.PasswordLastSet
        PasswordNeverExpires  = $user.PasswordNeverExpires
        AccountExpirationDate = $user.AccountExpirationDate
        LockedOut             = $user.LockedOut
        Enabled               = $user.Enabled
        WhenCreated           = $user.WhenCreated
        GroupMemberships      = $groupNames -join ', '
        Permissions           = $permissions
    }
}

# Function to get password policy audit
function Get-PasswordPolicyAudit {
    $users = Get-ADUser -Filter * -Properties PasswordLastSet, PasswordNeverExpires, AccountExpirationDate, LockedOut, Enabled
    $userAudits = @()

    foreach ($user in $users) {
        $userAudits += [PSCustomObject]@{
            UserName              = $user.SamAccountName
            PasswordLastSet       = $user.PasswordLastSet
            PasswordNeverExpires  = $user.PasswordNeverExpires
            AccountExpirationDate = $user.AccountExpirationDate
            LockedOut             = $user.LockedOut
            Enabled               = $user.Enabled
        }
    }

    return $userAudits
}

# Function to check for common passwords
function Check-CommonPasswords {
    param (
        [string]$UserName,
        [array]$CommonPasswords
    )

    $user = Get-ADUser -Identity $UserName -Properties UserPrincipalName

    if ($null -eq $user) {
        Write-Output "User $UserName not found."
        return $false
    }

    foreach ($password in $CommonPasswords) {
        $securePassword = ConvertTo-SecureString -AsPlainText -Force $password
        $credential = New-Object System.Management.Automation.PSCredential ($user.UserPrincipalName, $securePassword)
        
        try {
            # Attempt to authenticate with the provided password
            $null = $credential.GetNetworkCredential().Password
            if (Test-ADCredential -Credential $credential) {
                return $true
            }
        } catch {
            continue
        }
    }

    return $false
}

# Helper function to test credentials
function Test-ADCredential {
    param (
        [PSCredential]$Credential
    )

    $username = $Credential.UserName
    $password = $Credential.GetNetworkCredential().Password

    try {
        $context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('Domain')
        return $context.ValidateCredentials($username, $password)
    } catch {
        return $false
    }
}

# Function to audit user accounts based on Cyber Essentials requirements
function Audit-ADUsers {
    $UserAuditReport = @()
    $CommonPasswords = @("Password123", "123456", "qwerty", "letmein", "welcome", "admin", "password")

    # Get all users in the domain
    $allUsers = Get-ADUser -Filter * | Select-Object -ExpandProperty SamAccountName

    foreach ($user in $allUsers) {
        $userInfo = Get-UserInfo -UserName $user
        $isCommonPassword = Check-CommonPasswords -UserName $user -CommonPasswords $CommonPasswords

        $UserAuditReport += [PSCustomObject]@{
            UserName              = $userInfo.UserName
            DisplayName           = $userInfo.DisplayName
            EmailAddress          = $userInfo.EmailAddress
            LastLogonDate         = $userInfo.LastLogonDate
            PasswordLastSet       = $userInfo.PasswordLastSet
            PasswordNeverExpires  = $userInfo.PasswordNeverExpires
            AccountExpirationDate = $userInfo.AccountExpirationDate
            LockedOut             = $userInfo.LockedOut
            Enabled               = $userInfo.Enabled
            WhenCreated           = $userInfo.WhenCreated
            GroupMemberships      = $userInfo.GroupMemberships
            Permissions           = $userInfo.Permissions
            UsesCommonPassword    = $isCommonPassword
        }
    }

    # Export results to CSV
    $UserAuditReport | Export-Csv -Path "UserAuditReport.csv" -NoTypeInformation

    # Get password policy audit and export to CSV
    $PasswordPolicyAudit = Get-PasswordPolicyAudit
    $PasswordPolicyAudit | Export-Csv -Path "PasswordPolicyAudit.csv" -NoTypeInformation

    Write-Output "User audit completed. Reports generated: UserAuditReport.csv, PasswordPolicyAudit.csv"
}

# Execute the audit
Audit-ADUsers
