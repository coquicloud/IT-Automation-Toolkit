<#
.SYNOPSIS
    Toggles display settings (Internal / Extend / Duplicate / External).
    
.DESCRIPTION
    Uses the built-in Windows 'DisplaySwitch.exe' utility.
    Useful for conference room setups or kiosks.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function Show-Menu {
    Clear-Host
    Write-Host "--- Monitor Input Switcher ---" -ForegroundColor Cyan
    Write-Host "1. PC Screen Only (Internal)"
    Write-Host "2. Duplicate (Clone)"
    Write-Host "3. Extend ( Dual Monitor)"
    Write-Host "4. Second Screen Only (Projector)"
    Write-Host "Q. Quit"
}

do {
    Show-Menu
    $Choice = Read-Host "Select a mode"
    
    switch ($Choice) {
        "1" { DisplaySwitch.exe /internal; Write-Host "Switched to Internal." -ForegroundColor Yellow }
        "2" { DisplaySwitch.exe /clone; Write-Host "Switched to Duplicate." -ForegroundColor Yellow }
        "3" { DisplaySwitch.exe /extend; Write-Host "Switched to Extend." -ForegroundColor Yellow }
        "4" { DisplaySwitch.exe /external; Write-Host "Switched to External." -ForegroundColor Yellow }
        "Q" { exit }
        Default { Write-Warning "Invalid option." }
    }
    Start-Sleep -Seconds 2
} until ($Choice -eq "Q")
