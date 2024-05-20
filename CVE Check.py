import requests

def check_cve(vendor, product, version):
    url = f"https://cve.circl.lu/api/search/{vendor}/{product}/{version}"
    response = requests.get(url)
    if response.status_code == 200:
        vulnerabilities = response.json()
        for vuln in vulnerabilities:
            print(f"CVE: {vuln['id']}, Description: {vuln['summary']}")
    else:
        print("Error retrieving CVE information")

# Example usage
check_cve("microsoft", "windows", "10")
