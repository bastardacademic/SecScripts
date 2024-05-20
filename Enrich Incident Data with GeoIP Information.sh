import requests

def enrich_with_geoip(ip):
    response = requests.get(f"https://freegeoip.app/json/{ip}")
    if response.status_code == 200:
        return response.json()
    else:
        return None

# Example usage
ip = "8.8.8.8"
geoip_info = enrich_with_geoip(ip)
if geoip_info:
    print(f"GeoIP information for {ip}: {geoip_info}")
else:
    print(f"Failed to fetch GeoIP information for {ip}")
