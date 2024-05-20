# Function to encrypt data
function Encrypt-Data {
    param (
        [string]$PlainText,
        [string]$Key
    )

    # Convert plain text to bytes
    $plainBytes = [System.Text.Encoding]::UTF8.GetBytes($PlainText)
    
    # Create AES encryption provider
    $aes = New-Object System.Security.Cryptography.AesManaged
    $aes.Key = [Convert]::FromBase64String($Key)
    $aes.GenerateIV()
    
    # Encrypt the data
    $encryptor = $aes.CreateEncryptor()
    $encryptedBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)
    
    # Combine IV and encrypted bytes
    $combinedBytes = $aes.IV + $encryptedBytes
    $encryptedData = [Convert]::ToBase64String($combinedBytes)
    
    return $encryptedData
}

# Function to decrypt data
function Decrypt-Data {
    param (
        [string]$EncryptedData,
        [string]$Key
    )

    # Convert encrypted data to bytes
    $combinedBytes = [Convert]::FromBase64String($EncryptedData)
    
    # Extract IV and encrypted bytes
    $aes = New-Object System.Security.Cryptography.AesManaged
    $aes.Key = [Convert]::FromBase64String($Key)
    $aes.IV = $combinedBytes[0..15]
    $encryptedBytes = $combinedBytes[16..$combinedBytes.Length]
    
    # Decrypt the data
    $decryptor = $aes.CreateDecryptor()
    $plainBytes = $decryptor.TransformFinalBlock($encryptedBytes, 0, $encryptedBytes.Length)
    $plainText = [System.Text.Encoding]::UTF8.GetString($plainBytes)
    
    return $plainText
}

# Example usage:
# $key = [Convert]::ToBase64String((New-Object byte[] 32 | ForEach-Object { [char]([int][char]$($_ % 255)) } ))
# $encryptedData = Encrypt-Data -PlainText "Sensitive Data" -Key $key
# $decryptedData = Decrypt-Data -EncryptedData $encryptedData -Key $key
