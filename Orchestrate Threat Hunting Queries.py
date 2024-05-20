import requests

def execute_threat_hunting_query(query):
    api_url = "https://soarplatform.example.com/api/threathunting/queries"
    headers = {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json'
    }
    data = {
        'query': query
    }
    response = requests.post(api_url, headers=headers, json=data)
    return response.json()

# Example usage
query = "search=source:firewall AND action:blocked"
results = execute_threat_hunting_query(query)
print(f"Threat hunting results: {results}")
