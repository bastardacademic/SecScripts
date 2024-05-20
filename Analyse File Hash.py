import hashlib

def calculate_hash(file_path, hash_type="sha256"):
    hash_func = getattr(hashlib, hash_type)
    hasher = hash_func()
    with open(file_path, "rb") as file:
        buffer = file.read()
        hasher.update(buffer)
    return hasher.hexdigest()

# Example usage
file_path = "example.exe"
file_hash = calculate_hash(file_path)
print(f"{file_path} {hash_type}: {file_hash}")
