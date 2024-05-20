# Function to encrypt a file
function Encrypt-File {
    param (
        [string]$FilePath,
        [string]$Key
    )

    # Encrypt the file
    $data = Get-Content -Path $FilePath -Raw
    $encryptedData = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($data))
    Set-Content -Path $FilePath -Value $encryptedData
    Write-Host "File encrypted successfully"
}

# Function to decrypt a file
function Decrypt-File {
    param (
        [string]$FilePath,
        [string]$Key
    )

    # Decrypt the file
    $encryptedData = Get-Content -Path $FilePath -Raw
    $data = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encryptedData))
    Set-Content -Path $FilePath -Value $data
    Write-Host "File decrypted successfully"
}

# Example usage:
# Encrypt-File -FilePath "C:\SecretData.txt" -Key "YourEncryptionKey"
# Decrypt-File -FilePath "C:\SecretData.txt" -Key "YourEncryptionKey"
