try
{
    #LLSA protection
    $REG_CREDG = "HKLM:SYSTEM\CurrentControlSet\Control\Lsa"
    $REG_CREDG_value = (Get-ItemProperty -Path $REG_CREDG).RunAsPPL

    #Set 'Account lockout threshold' to 1-10 invalid login attempts
    Write-Host "Set 'Account lockout threshold' to 1-10 invalid login attempts"
    $NetAccounts = net accounts | select-string "lockout threshold" 
    if($netaccounts -like "*Never"){$netaccounts_Value = "0"} 

    #Check Microsoft Defender Application Guard managed mode
    if(((Get-computerinfo).OsTotalVisibleMemorySize /1024000) -gt "8") 
    {
        Write-Host "Check Microsoft Defender Application Guard managed mode"
        $DeviceGuard = (Get-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard).state
    } else {
        Write-Host "Not enough memory"
        $DeviceGuard = "Not enough memory"
    }
    Write-Host "Microsoft Defender Application Guard status: $DeviceGuard"

    if (($REG_CREDG_value -ne "1"  -or $netaccounts_Value -eq "0" -or $DeviceGuard -eq "Disabled")){
        #Below necessary for Intune as of 10/2019 will only remediate Exit Code 1

        #LSA protection
        write-host "Start remediation for: Forces LSA to run as Protected Process Light (PPL)"
        Remove-ItemProperty -Path $REG_CREDG -Name "RunAsPPL" -Force -ErrorAction SilentlyContinue
        New-ItemProperty -Path $REG_CREDG -Name "RunAsPPL" -Value "1"  -PropertyType Dword

        #Set lockout threshold to 10 
        net accounts /lockoutthreshold:10

        #Enable Application guard if meet the minimum specs
        if(((Get-computerinfo).OsTotalVisibleMemorySize /1024000) -gt "8") 
        {
            Write-Host "Enable Application guard"
            Enable-WindowsOptionalFeature -Online -featurename "Windows-Defender-ApplicationGuard" -NoRestart
        } 
        else {
            Write-Host "Not enough memory"
            $DeviceGuard = "Not enough memory"
        }
    }
    else{
        #Microsoft Defender Application Guard is Enabled, do not remediate
        Write-Host "Microsoft Defender Application Guard is Enabled, do not remediate"
        exit 0
    }  
} catch{
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
    }