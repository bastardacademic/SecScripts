# Function to modify an AD user account
function Modify-ADUserAccount {
    param (
        [string]$Username,
        [string]$NewFirstName,
        [string]$NewLastName,
        [string]$NewEmail
    )

    # Modify the AD user
    Set-ADUser -Identity $Username `
               -GivenName $NewFirstName `
               -Surname $NewLastName `
               -EmailAddress $NewEmail
}

# Example usage:
# Modify-ADUserAccount -Username "jdoe" -NewFirstName "Jonathan" -NewLastName "Doe" -NewEmail "jon.doe@yourdomain.com"
