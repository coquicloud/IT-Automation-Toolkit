<#
.SYNOPSIS
    Triggers the 'Quick Repair' or 'Online Repair' for Microsoft 365 apps silently.
    
.DESCRIPTION
    Uses the OfficeClickToRun.exe command line arguments.
    scene=quick (Offline) or scene=online (Full Download).
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [ValidateSet("Quick", "Online")]
    [string]$Type = "Quick"
)

Write-Host "--- Microsoft Office Repair Tool ---" -ForegroundColor Cyan

$OfficePath = "C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeClickToRun.exe"

if (-not (Test-Path $OfficePath)) {
    Write-Error "Office Click-to-Run executable not found."
    exit
}

Write-Host "Starting $Type Repair..." -ForegroundColor Yellow
Write-Host "Please close all Office apps (Word, Excel, Outlook)." 

if ($Type -eq "Quick") {
    Start-Process -FilePath $OfficePath -ArgumentList "scenario=Repair", "platform=x64", "culture=en-us", "RepairType=QuickRepair", "DisplayLevel=True" -Wait
}
else {
    Start-Process -FilePath $OfficePath -ArgumentList "scenario=Repair", "platform=x64", "culture=en-us", "RepairType=OnlineRepair", "DisplayLevel=True" -Wait
}

Write-Host "Repair process initiated." -ForegroundColor Green
