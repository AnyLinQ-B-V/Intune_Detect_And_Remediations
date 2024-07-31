# Specify the download path (adjust as needed)
$downloadPath = "$env:UserProfile\Pictures\Lockscreen.jpg"

if (Test-Path $downloadPath) {
    Write-Host "Lockscreen image is already installed, no remedation needed"
    exit 0
} else {
    Write-Host "Lockscreen image not available, run remediation"
    exit 1
}
