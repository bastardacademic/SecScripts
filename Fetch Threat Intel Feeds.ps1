# Function to fetch threat intelligence feeds
function Get-ThreatIntelligence {
    param (
        [string]$FeedUrl = "https://example.com/threatintel/feed"
    )

    # Fetch the threat intelligence feed
    $feed = Invoke-RestMethod -Uri $FeedUrl
    return $feed
}

# Example usage:
# $threatIntel = Get-ThreatIntelligence -FeedUrl "https://example.com/threatintel/feed"
# $threatIntel | Format-Table
