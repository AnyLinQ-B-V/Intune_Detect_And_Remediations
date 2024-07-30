# Intune_Detect_And_Remediations
Custom Intune Detect and Remediation scripts

* Warning: Before use in a production environment, test the scripts first. Use at your own risk

# Disk event finder with toast notification
Detect: This detect script checks the Windows system events to see if disk errors with ID 7 or 52 have been created.
Remediate: Disk event finder with toas notification BurntToast to display a Toast notification on the client with the disk events.
![afbeelding](https://raw.githubusercontent.com/AnyLinQ-B-V/Intune_Detect_And_Remediations/main/assets/273379356-9abda0ab-0789-4369-a7de-e5ba7aadc33e.png)

Intune running Context: 
 - Run this script using the logged-on credentials set to Yes
 - Enforce script signature check set to No
 - Run script in 64-bit PowerShell set to Yes

Github page to BurnToast: https://github.com/Windos/BurntToast

