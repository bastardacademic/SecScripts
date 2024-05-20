import requests

def fetch_osint(domain):
    api_url = f"https://api.osint.example.com/domain/{domain}"
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.json()
    else:
        return None

# Example usage
domain = "example.com"
osint_data = fetch_osint(domain)
if osint_data:
    print(osint_data)
else:
    print("Failed to fetch OSINT data.")
