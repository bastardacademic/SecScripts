# Function to detect phishing emails in a mailbox
function Detect-PhishingEmails {
    param (
        [string]$Mailbox,
        [string]$PhishingKeywords = "urgent,important,verify,login,update"
    )

    # Convert keywords to array
    $keywords = $PhishingKeywords -split ","

    # Get emails from the mailbox
    $emails = Get-MailboxFolderStatistics -Identity $Mailbox | Get-MailboxItemStatistics

    # Detect phishing emails based on keywords
    $phishingEmails = $emails | Where-Object {
        $emailContent = $_.Subject + " " + $_.Body
        foreach ($keyword in $keywords) {
            if ($emailContent -match $keyword) {
                return $true
            }
        }
        return $false
    }

    return $phishingEmails
}

# Example usage:
# $phishingEmails = Detect-PhishingEmails -Mailbox "user@domain.com" -PhishingKeywords "urgent,important,verify"
# $phishingEmails | Format-Table -Property Subject, ReceivedTime
