# Specify the download path (adjust as needed)
$downloadPath = "$env:UserProfile\Pictures\Wallpaper.jpg"

if (Test-Path $downloadPath) {
    Write-Host "Wallpaper image downloaded and saved successfully"
    exit 0
} else {
    Write-Host "Wallpaper image download failed"
    exit 1
}
