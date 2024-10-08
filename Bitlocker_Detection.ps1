# get the tpm status
$tpmStatus = Get-Tpm

# if tpm is not ready or not present, remediation is applicable; exit 1
if ($tpmStatus.TpmReady -eq $false -or $tpmStatus.TpmPresent -eq $false) {
    Write-Host "TPM is not ready or not present. Remediation is applicable to this device."
    exit 1
}

# get bitlocker status
$status = Get-BitLockerVolume -MountPoint "C:"

# if protection status is on and encryption percentage is 100, remediation is not applicable; exit 0, else exit 1
if ($status.ProtectionStatus -eq "On" -and $status.EncryptionPercentage -eq 100) {
    Write-Host "Bitlocker is already enabled on the device. Remediation is not applicable to this device." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Bitlocker is not enabled on the device. Remediation is applicable to this device." -ForegroundColor Red
    exit 1
}