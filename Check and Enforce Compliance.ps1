# Function to check and enforce compliance with security policies
function Enforce-SecurityCompliance {
    param (
        [string]$DomainController
    )

    # Example baseline settings
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -MinPasswordLength 14
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -MaxPasswordAge (New-TimeSpan -Days 60)
    Set-ADDefaultDomainPasswordPolicy -Identity $DomainController -PasswordHistoryCount 24

    # Other security settings can be added here
    Write-Host "Security compliance settings enforced."
}

# Example usage:
# Enforce-SecurityCompliance -DomainController "YourDC"
