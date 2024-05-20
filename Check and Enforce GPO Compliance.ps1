# Function to check and enforce GPO compliance
function Check-GPOCompliance {
    param (
        [string]$GPOName
    )

    # Check for GPO compliance
    $gpo = Get-GPO -Name $GPOName
    $gpoReport = Get-GPOReport -Guid $gpo.Id -ReportType Html -Path "C:\GPOReports\$GPOName.html"
    Start-Process "C:\GPOReports\$GPOName.html"
}

# Example usage:
# Check-GPOCompliance -GPOName "SecurityPolicy"
