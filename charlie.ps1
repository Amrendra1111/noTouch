# PowerShell script to add a predefined SSH public key
$sshDir = "$env:USERPROFILE\.ssh"
$authorizedKeys = "$sshDir\authorized_keys"

# Ensure the .ssh directory exists
if (-Not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force
}

# Predefined SSH public key (your ssh public key)
$sshKey = "ssh-rsa AAAAB3Nza== example@gmail.com"

# Add the key to authorized_keys
if (-Not (Test-Path $authorizedKeys)) {
    # Create the file if it doesn't exist
    $sshKey | Out-File -FilePath $authorizedKeys -Encoding ascii
} else {
    # Append the key to the file if it does exist
    $sshKey | Add-Content -Path $authorizedKeys
}
