<#
.SYNOPSIS
    Exports all third-party drivers to a folder.
    
.DESCRIPTION
    Uses 'Export-WindowsDriver' to save all non-inbox drivers.
    Critical before performing a 'Nuke and Pave' reinstall.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$BackupPath = "$env:UserProfile\Desktop\DriverBackup"

Write-Host "--- Windows Driver Backup ---" -ForegroundColor Cyan

if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Force -Path $BackupPath | Out-Null
}

Write-Host "Exporting drivers to: $BackupPath" -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Gray

try {
    Export-WindowsDriver -Online -Destination $BackupPath -ErrorAction Stop
    Write-Host "Driver backup complete!" -ForegroundColor Green
    Invoke-Item $BackupPath
}
catch {
    Write-Error "Failed to export drivers. Run as Admin."
}
