# https://github.com/bonben365
# Create temporary directory
$null = New-Item -Path $env:temp\kms -ItemType Directory -Force
Set-Location $env:temp\kms

# Download required files
$uri = "https://filedn.com/lOX1R8Sv7vhpEG9Q77kMbn0/bonben365.com/Zip/microsoftstore-win-ltsc.zip"
$null = Invoke-WebRequest -Uri $uri -OutFile "microsoftstore-win-ltsc.zip" -ErrorAction:SilentlyContinue

# Extract downloaded file then run the script
Expand-Archive .\microsoftstore-win-ltsc.zip -Force -ErrorAction:SilentlyContinue
Set-Location "$env:temp\kms\microsoftstore-win-ltsc"
cmd.exe /c .\add-store.cmd -nonewline

# Checking installed apps
$packages = @("Microsoft.VCLibs","DesktopAppInstaller","WindowsStore")
$report = ForEach ($package in $packages){Get-AppxPackage -Name *$package* | select Name,Version,Status }
write-host "Installed packages:"
$report | format-table

# Cleanup
Set-Location "$env:temp"
Remove-Item $env:temp\kms -Recurse -Force
