# Function to enforce password policies
function Enforce-PasswordPolicy {
    param (
        [string]$DomainController,
        [int]$MinLength = 12,
        [int]$MaxAgeDays = 60,
        [int]$HistoryCount = 24
    )

    # Enforce password policies
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -MinPasswordLength $MinLength
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -MaxPasswordAge (New-TimeSpan -Days $MaxAgeDays)
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -PasswordHistoryCount $HistoryCount
}

# Example usage:
# Enforce-PasswordPolicy -DomainController "YourDC" -MinLength 12 -MaxAgeDays 60 -HistoryCount 24
