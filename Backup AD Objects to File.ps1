# Function to backup AD objects to a file
function Backup-ADObjects {
    param (
        [string]$BackupPath = "C:\ADBackups",
        [string]$DomainController
    )

    # Create backup directory if it doesn't exist
    if (-not (Test-Path $BackupPath)) {
        New-Item -Path $BackupPath -ItemType Directory
    }

    # Backup users, groups, and computers
    Get-ADUser -Filter * -Server $DomainController | Export-Clixml -Path "$BackupPath\Users.xml"
    Get-ADGroup -Filter * -Server $DomainController | Export-Clixml -Path "$BackupPath\Groups.xml"
    Get-ADComputer -Filter * -Server $DomainController | Export-Clixml -Path "$BackupPath\Computers.xml"

    Write-Host "AD objects backed up to $BackupPath"
}

# Example usage:
# Backup-ADObjects -BackupPath "C:\ADBackups" -DomainController "YourDC"
