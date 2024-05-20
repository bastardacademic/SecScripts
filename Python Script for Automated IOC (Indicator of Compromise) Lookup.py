import requests

def lookup_ioc(ioc):
    api_url = f"https://api.threatintelligenceplatform.com/v1/reputation?apikey=YOUR_API_KEY&domain={ioc}"
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.json()
    else:
        return None

# Example usage
ioc = "malicious.com"
ioc_info = lookup_ioc(ioc)
if ioc_info:
    print(f"Reputation for {ioc}: {ioc_info['reputation']}")
else:
    print(f"Failed to fetch information for {ioc}")
