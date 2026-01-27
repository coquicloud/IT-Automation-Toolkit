<#
.SYNOPSIS
    Parses the registry to show a audit trail of connected USB storage devices.
    
.DESCRIPTION
    Reads from HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR.
    Useful for security audits to see what has been plugged in.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

Write-Host "--- USB Connection History ---" -ForegroundColor Cyan

$Path = "HKLM:\SYSTEM\CurrentControlSet\Enum\USBSTOR"
$Devices = Get-ChildItem -Path $Path -ErrorAction SilentlyContinue

foreach ($Device in $Devices) {
    # Device Name is usually encoded in the registry key name
    $Name = $Device.PSChildName
    
    # Get Subkeys (Instance IDs / Serial Numbers)
    $Instances = Get-ChildItem -Path $Device.PSPath
    
    foreach ($Instance in $Instances) {
        $FriendlyName = $Instance.GetValue("FriendlyName")
        $Mfg = $Instance.GetValue("Mfg")
        
        Write-Host "Device: $($FriendlyName -replace ';','')" -ForegroundColor Yellow
        Write-Host "  Model: $Name"
        Write-Host "  Serial: $($Instance.PSChildName)"
        Write-Host "-------------------------------------" -ForegroundColor Gray
    }
}
