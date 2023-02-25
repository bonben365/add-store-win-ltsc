$null = New-Item -Path $env:temp\kms -ItemType Directory -Force
Set-Location $env:temp\kms

$uri = "https://filedn.com/lOX1R8Sv7vhpEG9Q77kMbn0/bonben365.com/Zip/microsoftstore-win-ltsc.zip"
$null = Invoke-WebRequest -Uri $uri -OutFile "microsoftstore-win-ltsc.zip" -ErrorAction:SilentlyContinue

$null = Expand-Archive .\microsoftstore-win-ltsc.zip -Force -ErrorAction:SilentlyContinue
Invoke-Item $env:temp\kms
Set-Location "$env:temp\kms\microsoftstore-win-ltsc"
cmd.exe /c .\add-store.cmd -nonewline

$packages = @("Microsoft.VCLibs","DesktopAppInstaller","WindowsStore")
$report = ForEach ($package in $packages){Get-AppxPackage -Name *$package* | select Name,Version,Status }
Write-Host "Your Windows edition: $report"
