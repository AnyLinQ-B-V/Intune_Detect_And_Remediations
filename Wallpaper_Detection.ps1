# Specify the download path (adjust as needed)
$downloadPath = "$env:UserProfile\Pictures\Wallpaper.jpg"

if (Test-Path $downloadPath) {
    Write-Host "Wallpaper image is already installed, no remedation needed"
    exit 0
} else {
    Write-Host "Wallpaper image not available, run remediation"
    exit 1
}
