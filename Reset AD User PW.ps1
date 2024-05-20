# Function to reset an AD user password
function Reset-ADUserPassword {
    param (
        [string]$Username,
        [string]$NewPassword
    )

    # Reset the AD user password
    Set-ADAccountPassword -Identity $Username -NewPassword (ConvertTo-SecureString $NewPassword -AsPlainText -Force) -Reset
}

# Example usage:
# Reset-ADUserPassword -Username "jdoe" -NewPassword "N3wP@ssw0rd!"
