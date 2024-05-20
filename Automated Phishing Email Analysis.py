import requests
import json

def analyze_email(email_id):
    url = f"https://soarplatform.example.com/api/emails/{email_id}/analyze"
    headers = {
        "Authorization": "Bearer YOUR_API_KEY"
    }
    response = requests.post(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        return None

# Example usage
email_id = 5678
analysis_result = analyze_email(email_id)
if analysis_result:
    print(json.dumps(analysis_result, indent=4))
