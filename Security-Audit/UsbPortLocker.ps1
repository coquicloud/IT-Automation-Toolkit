<#
.SYNOPSIS
    Disables write access to USB storage devices (Read-Only mode).
    
.DESCRIPTION
    Modifies the registry StorageDevicePolicies to prevent data theft.
    Set $Unlock = $true to revert changes.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [switch]$Unlock
)

$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies"

Write-Host "--- USB Port Locker ---" -ForegroundColor Cyan

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

if ($Unlock) {
    Set-ItemProperty -Path $RegPath -Name "WriteProtect" -Value 0
    Write-Host "USB Write Protection: DISABLED (Ports Unlocked)" -ForegroundColor Green
}
else {
    Set-ItemProperty -Path $RegPath -Name "WriteProtect" -Value 1
    Write-Host "USB Write Protection: ENABLED (Read-Only Mode)" -ForegroundColor Red
}

Write-Host "Note: You may need to reconnect existing USB drives for changes to take effect." -ForegroundColor Gray
