# Replace with your desired image URL
$imageUrl = "https://anylinq.com/hubfs/images/wallpaper-"
$imageExt = ".jpg"

# Specify the download path (adjust as needed)
$downloadPath = "$env:UserProfile\Pictures\Wallpaper.jpg"

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
}

# Set the image as wallpaper
try {
    [void] [System.Runtime.InteropServices.Marshal]::SystemDefaultWallpaper($downloadPath)
} catch [System.Exception] {
    Write-Host "Error setting wallpaper: $($_.Exception.Message)"
    exit 1
}

Write-Host "Wallpaper set successfully!"
