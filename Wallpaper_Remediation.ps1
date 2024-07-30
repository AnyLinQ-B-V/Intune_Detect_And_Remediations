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

# Set stretched for multimonitor use
function Set-DesktopWallpaper {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][String]$PicturePath,
        [ValidateSet('Tiled', 'Centered', 'Stretched', 'Fill', 'Fit', 'Span')]$Style = 'Stretched'
    )


    BEGIN {
        $Definition = @"
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
"@

        Add-Type -MemberDefinition $Definition -Name Win32SystemParametersInfo -Namespace Win32Functions
        $Action_SetDeskWallpaper = [int]20
        $Action_UpdateIniFile = [int]0x01
        $Action_SendWinIniChangeEvent = [int]0x02

        $HT_WallPaperStyle = @{
            'Tiles'     = 0
            'Centered'  = 0
            'Stretched' = 2
            'Fill'      = 10
            'Fit'       = 6
            'Span'      = 22
        }

        $HT_TileWallPaper = @{
            'Tiles'     = 1
            'Centered'  = 0
            'Stretched' = 0
            'Fill'      = 0
            'Fit'       = 0
            'Span'      = 0
        }

    }


    PROCESS {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name wallpaperstyle -Value $HT_WallPaperStyle[$Style]
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name tilewallpaper -Value $HT_TileWallPaper[$Style]
        $null = [Win32Functions.Win32SystemParametersInfo]::SystemParametersInfo($Action_SetDeskWallpaper, 0, $PicturePath, ($Action_UpdateIniFile -bor $Action_SendWinIniChangeEvent))
    }
}

Set-DesktopWallpaper $downloadPath