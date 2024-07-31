# Replace with your desired image URL
$imageUrl = "https://anylinq.com/hubfs/images/lockscreen-"
$imageExt = ".jpg"

# Specify the download path (adjust as needed)
$downloadPath = "$env:UserProfile\Pictures\Lockscreen.jpg"

# Create the Pictures folder if it doesn't exist
if (!(Test-Path "$env:UserProfile\Pictures")) {
    New-Item -Path "$env:UserProfile\Pictures" -ItemType Directory
}

$Details = Get-WmiObject Win32_VideoController
$Model = $Details.Caption
$RAMSize = $Details.AdapterRAM
$ResWidth = "$($Details.CurrentHorizontalResolution)".Trim()
$ResHeight = "$($Details.CurrentVerticalResolution)".Trim()
$RefreshRate = $Details.CurrentRefreshRate
$DriverVersion = $Details.DriverVersion
$Status = $Details.Status

$imageUrl = $imageUrl + $ResWidth + "x" + $ResHeight + $imageExt
Write-Host "Found: $Model GPU, $($ResWidth)x$($ResHeight) pixels, $($RefreshRate)Hz, driver $DriverVersion) - status $Status"
Write-Host "Downloading $imageUrl"

# Download the image
try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($imageUrl, $downloadPath)
} catch [System.Net.WebException] {
    Write-Host "Error downloading image: $($_.Exception.Message)"
    exit 1
}   	1.l

# Set stretched for multimonitor use
function Set-LockScreenImage {

}

# Call the function
Write-Host "Set-LockScreenImage -imagePath $downloadPath"

$scriptContent = @"
# Your script content here
    # Create the registry key if it doesn't exist
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Force | Out-Null

    # Set the lock screen image path
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value $downloadPath

    # Prevent lock screen slideshow and overlays
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenOverlaysDisabled" -Value 1
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "NoLockScreenSlideshow" -Value 1

    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value "1" -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value $imageUrl -PropertyType STRING -Force | Out-Null
"@

Write-Host $scriptContent
powershell -ExecutionPolicy Bypass -Command $scriptContent