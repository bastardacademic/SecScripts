import requests

def fetch_incident_details(incident_id):
    url = f"https://soarplatform.example.com/api/incidents/{incident_id}"
    headers = {
        "Authorization": "Bearer YOUR_API_KEY"
    }
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        return None

def triage_incident(incident):
    if "malware" in incident["description"].lower():
        return "high"
    elif "phishing" in incident["description"].lower():
        return "medium"
    else:
        return "low"

# Example usage
incident_id = 1234
incident = fetch_incident_details(incident_id)
if incident:
    priority = triage_incident(incident)
    print(f"Incident {incident_id} triaged with priority: {priority}")
