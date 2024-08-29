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
$publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3H/3TYtWYvNMJQiOYqTTno/crf1D4pQhj0ngkMUX39CJjURFsmMPhwN1KYIBVubj87XRuaeUPFB1wpOeRp0LrvKal85v0HXuimkZbNwwXcIeh16wWnpw60yjmDUYKok3I0a82L/TRNJivFyyI3R3UNDDpWC5kkm7AYxqMSuZoy+fM6mQBKyxq0WjkA+jsYCvtK0bzBsHzfCSRBqpfxls/rLIeKneau/JGzwwQIxfQQ2tRFLjyAYcZ9tvYMyZUX5DOpP2QXB9jAByPJ8y5Y0/+i6IQIBjAemtHAHdLJdA74j7Xb46EHtUD5H3oD3yqqtw4ZtnsdKa5Hxm5WlqeFK8iDlXvZz3awGQ9mz/6qkt8nAJEB9NRrQi4gYf5Iz8V2VhyXQI5Ry+R/RLhoCqN+TXPQdOQWxFEguS+MHIdw41aQM+AEW2e0KpcU3bHHVheLSzxQmfQtp6J6KDWfWYlMNuABo8nV/Kqyhaol6+ILfN0X3TM/+qkvw4KgpYrNUY4j/YLgwYNHaO023EEZjw2MVMMPaxKPMtyZwegRaHVj3KItVHR4xs2zukVnyCMPAw67xQsRHIWi7vN1pwjzZLYjUpmmOP3EYf6mGx290dP5wV/QJz7o+XDc2AEo7iYfpZVzAQD4Puq0ZdIzIJXA1ytGlBQc6QRiSVmYvbdakgr0/lPCQ== amrendra1111singh@gmail.com"
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
