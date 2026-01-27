<#
.SYNOPSIS
    Exports BitLocker recovery keys to a central log.

.DESCRIPTION
    Retrieves the BitLocker recovery password for all encrypted volumes
    and exports them to a CSV file on the Desktop.
    Requires Administrative privileges.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$ExportPath = "$env:UserProfile\Desktop\BitLockerKeys.csv"

Write-Host "--- BitLocker Key Export ---" -ForegroundColor Cyan

try {
    # Check privileges
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        throw "This script requires Administrator privileges."
    }

    $Volumes = Get-BitLockerVolume -ErrorAction Stop
    
    foreach ($Vol in $Volumes) {
        $KeyProtector = $Vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
        
        if ($KeyProtector) {
            $RecoveryPassword = $KeyProtector.RecoveryPassword
            
            $Info = [PSCustomObject]@{
                ComputerName     = $env:COMPUTERNAME
                MountPoint       = $Vol.MountPoint
                EncryptionStatus = $Vol.VolumeStatus
                RecoveryKey      = $RecoveryPassword
                DateCaptured     = Get-Date
            }

            Write-Host "Exporting key for $($Vol.MountPoint)..." -ForegroundColor Yellow
            $Info | Export-Csv -Path $ExportPath -Append -NoTypeInformation
        }
        else {
            Write-Warning "No Recovery Password protector found for volume $($Vol.MountPoint)"
        }
    }
    
    if (Test-Path $ExportPath) {
        Write-Host "Keys successfully exported to: $ExportPath" -ForegroundColor Green
    }

}
catch {
    Write-Error "Failed to export keys: $($_.Exception.Message)"
    Write-Warning "Ensure BitLocker is enabled and you are running as Admin."
}
