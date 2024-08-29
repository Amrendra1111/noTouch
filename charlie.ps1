# PowerShell script to add a predefined SSH public key
$sshDir = "$env:USERPROFILE\.ssh"
$authorizedKeys = "$sshDir\authorized_keys"

# Ensure the .ssh directory exists
if (-Not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force
}

# Predefined SSH public key
$sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3H/3TYtWYvNMJQiOYqTTno/crf1D4pQhj0ngkMUX39CJjURFsmMPhwN1KYIBVubj87XRuaeUPFB1wpOeRp0LrvKal85v0HXuimkZbNwwXcIeh16wWnpw60yjmDUYKok3I0a82L/TRNJivFyyI3R3UNDDpWC5kkm7AYxqMSuZoy+fM6mQBKyxq0WjkA+jsYCvtK0bzBsHzfCSRBqpfxls/rLIeKneau/JGzwwQIxfQQ2tRFLjyAYcZ9tvYMyZUX5DOpP2QXB9jAByPJ8y5Y0/+i6IQIBjAemtHAHdLJdA74j7Xb46EHtUD5H3oD3yqqtw4ZtnsdKa5Hxm5WlqeFK8iDlXvZz3awGQ9mz/6qkt8nAJEB9NRrQi4gYf5Iz8V2VhyXQI5Ry+R/RLhoCqN+TXPQdOQWxFEguS+MHIdw41aQM+AEW2e0KpcU3bHHVheLSzxQmfQtp6J6KDWfWYlMNuABo8nV/Kqyhaol6+ILfN0X3TM/+qkvw4KgpYrNUY4j/YLgwYNHaO023EEZjw2MVMMPaxKPMtyZwegRaHVj3KItVHR4xs2zukVnyCMPAw67xQsRHIWi7vN1pwjzZLYjUpmmOP3EYf6mGx290dP5wV/QJz7o+XDc2AEo7iYfpZVzAQD4Puq0ZdIzIJXA1ytGlBQc6QRiSVmYvbdakgr0/lPCQ== amrendra1111singh@gmail.com"

# Add the key to authorized_keys
if (-Not (Test-Path $authorizedKeys)) {
    # Create the file if it doesn't exist
    $sshKey | Out-File -FilePath $authorizedKeys -Encoding ascii
} else {
    # Append the key to the file if it does exist
    $sshKey | Add-Content -Path $authorizedKeys
}
