step1: go to the target windows machine
step2: open powershell as admin
step3: install PS2EXE from PowerShell Gallery
(Install-Module -Name ps2exe -Scope CurrentUser -Force)
step4: Convert the .ps1 script to .exe 
(ps2exe -InputFile "charlie.ps1" -OutputFile "charlie.exe")
step5: run the executor
step 6: go to the client machine
step 7: do the ssh 
(ssh -i /path/to/your/private/key username@windowsIp)
