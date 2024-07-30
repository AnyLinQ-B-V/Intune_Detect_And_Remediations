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
    $Button = New-BTButton -Content 'Contact Interne IT' -Arguments 'mailto:support@anylinq.com'
    New-BurntToastNotification -Text $EventMessage -Sound Default -Button $Button
}


# Define the log name and event IDs for disk errors and warnings
$eventLogName = 'System'
$errorEventID = 7     # The event ID for disk errors
$warningEventID = 52  # The event ID for disk warnings

# Check if there is a recent disk error or warning event
$latestErrorEvent = Get-WinEvent -LogName $eventLogName -MaxEvents 1 | Where-Object { $_.Id -eq $errorEventID }
$latestWarningEvent = Get-WinEvent -LogName $eventLogName -MaxEvents 1 | Where-Object { $_.Id -eq $warningEventID }

if ($latestErrorEvent -or $latestWarningEvent) {
    # There is a recent disk error or warning event
    $eventMessage = "Disk issues have been found!" + [Environment]::NewLine + "Contact Interne IT via support@anylinq.com"
           
    # Display the graphical notification
    Show-Notification -EventMessage $eventMessage
}