# Intune_Detect_And_Remediations
Custom Intune Detect and Remediation scripts

* Warning: Before use in a production environment, test the scripts first. Use at your own risk

# Disk event finder with toast notification
 - Detect: This detect script checks the Windows system events to see if disk errors with ID 7 or 52 have been created.
 - Remediate: Disk event finder with toast notification BurntToast to display a Toast notification on the client with the disk events.

![afbeelding](https://raw.githubusercontent.com/AnyLinQ-B-V/Intune_Detect_And_Remediations/main/assets/Disk_Events_Remediation.jpg)

Intune running Context: 
 - Run this script using the logged-on credentials set to Yes
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes

Github page to BurnToast: https://github.com/Windos/BurntToast

# Uptime Detection
 - Detect: This detect script checks the Windows uptime to see if a user has not rebooted his/her laptop lately.
 - Remediate: Uptime detection with toast notification BurntToast to display a Toast notification on the client to ensure the client will reboot the device.


![afbeelding](https://raw.githubusercontent.com/AnyLinQ-B-V/Intune_Detect_And_Remediations/main/assets/Uptime_Remediation.png)

Intune running Context: 
 - Run this script using the logged-on credentials set to Yes
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes

Github page to BurnToast: https://github.com/Windos/BurntToast


# Windows bloatware removal
 - Detect: This detect script checks if any software listed in the bloatware list is installed.
 - Remediate: Uninstall any software that is in the bloatware list.

![afbeelding](https://raw.githubusercontent.com/AnyLinQ-B-V/Intune_Detect_And_Remediations/main/assets/Windows_bloatware_Remediation.png)

Intune running Context: 
 - Run this script using the logged-on credentials set to No
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes


# Set Windows Wallpaper (Wallpaper_Detection.ps1)
 - Detect: This detect script checks if "$env:UserProfile\Pictures\Wallpaper.jpg" exists.
 - Remediate: If "$env:UserProfile\Pictures\Wallpaper.jpg" is not found, detect the users screen resolution, download the custom resolution wallpaper and set it as the default wallpaper.
 - Note: This allows users to set their own wallpaper afterwards.

![afbeelding](https://anylinq.com/hubfs/images/wallpaper-3456x2160.jpg)

Intune running Context: 
 - Run this script using the logged-on credentials set to No
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes

# Set Windows Lockscreen (Lockscreen_Detection.ps1)
 - Detect: This detect script checks if "$env:UserProfile\Pictures\Lockscreen.jpg" exists.
 - Remediate: If "$env:UserProfile\Pictures\Lockscreen.jpg" is not found, detect the users screen resolution, download the custom resolution wallpaper and set it as the default wallpaper.
 - Note: This allows users to set their own lockscreen afterwards.

![afbeelding](https://anylinq.com/hubfs/images/lockscreen-3456x2160.jpg)

Intune running Context: 
 - Run this script using the logged-on credentials set to No
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes