# Function to restore AD objects from a backup file
function Restore-ADObjects {
    param (
        [string]$BackupPath = "C:\ADBackups",
        [string]$DomainController
    )

    # Restore users, groups, and computers
    Import-Clixml -Path "$BackupPath\Users.xml" | ForEach-Object { New-ADUser $_ }
    Import-Clixml -Path "$BackupPath\Groups.xml" | ForEach-Object { New-ADGroup $_ }
    Import-Clixml -Path "$BackupPath\Computers.xml" | ForEach-Object { New-ADComputer $_ }

    Write-Host "AD objects restored from $BackupPath"
}

# Example usage:
# Restore-ADObjects -BackupPath "C:\ADBackups" -DomainController "YourDC"
