<#
.SYNOPSIS
    Deletes the Outlook mail profile key from the Registry.
    
.DESCRIPTION
    Forces Outlook to create a fresh profile on next launch.
    Fixes corruption that Repair cannot fix.
    Backup the key first just in case.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$RegPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook"
$BackupPath = "$env:TEMP\OutlookProfileBackup.reg"

Write-Host "--- Outlook Profile Reset ---" -ForegroundColor Cyan
Write-Host "WARNING: This will remove your configured email accounts from Outlook." -ForegroundColor Red
Write-Host "You will need to sign in again."

$Confirm = Read-Host "Are you sure? (Y/N)"
if ($Confirm -ne "Y") { exit }

if (Test-Path $RegPath) {
    # Backup
    Write-Host "Backing up registry key..." -ForegroundColor Gray
    cmd /c "reg export HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook $BackupPath /y"
    
    # Delete
    Remove-Item -Path $RegPath -Recurse -Force
    Write-Host "Profile deleted. Please restart Outlook." -ForegroundColor Green
}
else {
    Write-Warning "Outlook profile registry key not found."
}
