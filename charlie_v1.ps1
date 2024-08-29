# Check if OpenSSH Server is installed
$sshInstalled = Get-WindowsFeature -Name OpenSSH-Server

if (-not $sshInstalled.Installed) {
    # Install OpenSSH Server
    Install-WindowsFeature -Name OpenSSH-Server
    
    # Start and set OpenSSH Server service to automatic
    Start-Service -Name sshd
    Set-Service -Name sshd -StartupType 'Automatic'
    
    # Add the firewall rule for SSH
    New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}

# Ensure the .ssh directory exists
$sshDirectory = "$env:USERPROFILE\.ssh"
if (-not (Test-Path -Path $sshDirectory)) {
    New-Item -ItemType Directory -Path $sshDirectory
}

# Add your public key to the authorized_keys file
$publicKey = "ssh-rsa AAAAB3Nza== example@gmail.com"
$authorizedKeysPath = "$sshDirectory\authorized_keys"

if (-not (Test-Path -Path $authorizedKeysPath)) {
    New-Item -ItemType File -Path $authorizedKeysPath
}

Add-Content -Path $authorizedKeysPath -Value $publicKey

# Ensure proper permissions on the .ssh directory and authorized_keys file
icacls $sshDirectory /inheritance:r
icacls $sshDirectory /grant:r "$($env:USERNAME):(OI)(CI)F"
icacls $authorizedKeysPath /inheritance:r
icacls $authorizedKeysPath /grant:r "$($env:USERNAME):F"

# Restart the SSH service to apply any changes
Restart-Service -Name sshd
