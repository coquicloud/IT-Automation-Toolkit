<#
.SYNOPSIS
    Lists, creates, or deletes VSS Snapshots (System Restore points).
    
.DESCRIPTION
    Wrapper for vssadmin. Use to create a quick restore point before changes.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function Show-Menu {
    Clear-Host
    Write-Host "--- Volume Shadow Copy Manager ---" -ForegroundColor Cyan
    Write-Host "1. List Shadows"
    Write-Host "2. Create New Shadow (C:)"
    Write-Host "3. Delete Oldest Shadow"
    Write-Host "Q. Quit"
}

do {
    Show-Menu
    $Choice = Read-Host "Select an option"
    
    switch ($Choice) {
        "1" { vssadmin list shadows; Pause }
        "2" { 
            Write-Host "Creating Shadow Copy..." -ForegroundColor Yellow
            wmic shadowcopy call create Volume='C:\'
            Pause 
        }
        "3" {
            Write-Host "Deleting Oldest Shadow..." -ForegroundColor Red
            vssadmin delete shadows /For=C: /Oldest
            Pause
        }
        "Q" { exit }
    }
} until ($Choice -eq "Q")
