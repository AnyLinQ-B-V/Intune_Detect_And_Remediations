
# Setting variables
$Uptime= get-computerinfo | Select-Object OSUptime 
$moduleName = "BurntToast"

# Check if the module is installed
if (!(Get-Module -ListAvailable -Name $moduleName)) {
    try {
        Install-Module $moduleName -Force
    } catch {
        Write-Host "Error installing module '$moduleName': $($_.Exception.Message)"
    }
} else {
    # Check if the module is loaded
    if (!(Get-Module -Name $moduleName)) {
        Import-Module $moduleName
    }
}

function Show-Notification {
    param (
        [string]$EventMessage
    )

    # Import the BurntToast module
    Import-Module BurntToast

    # Display a notification
    #New-BurntToastNotification -AppLogo 'C:\Path\To\Your\Logo.png' -Text $EventMessage
    New-BurntToastNotification -Text $EventMessage -Sound Default
}
        
if ($Uptime.OsUptime.Days -ge 7){
    # There is a recent disk error or warning event
    $eventMessage = "Your device has not performed a reboot in the last $($Uptime.OsUptime.Days) days, this will impact performance and stability of your laptop." + [Environment]::NewLine + [Environment]::NewLine + "Please save your work and restart your device today. Thank you in advance."

    # Display the graphical notification
    Show-Notification -EventMessage $eventMessage
}

Exit 0