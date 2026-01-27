<#
.SYNOPSIS
    Unified Launcher for the IT Automation Toolkit.
    
.DESCRIPTION
    Provides a text-based menu to navigate categories and execute scripts.
    Dynamically scans folders for .ps1 and .bat files.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function Show-Header {
    Clear-Host
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "   IT AUTOMATION TOOLKIT - UNIFIED LAUNCHER" -ForegroundColor White
    Write-Host "   Coqui Cloud Dev Co." -ForegroundColor DarkGray
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Get-ScriptCategories {
    Get-ChildItem -Directory | Where-Object { $_.Name -notin @(".git", ".vscode") }
}

function Show-CategoryMenu {
    param($Categories)
    Show-Header
    Write-Host "Select a Category:" -ForegroundColor Yellow
    $i = 1
    foreach ($Cat in $Categories) {
        Write-Host "  $i. $($Cat.Name)"
        $i++
    }
    Write-Host "  Q. Quit"
    Write-Host ""
}

function Show-ScriptMenu {
    param($Category)
    $Scripts = Get-ChildItem -Path $Category.FullName -Include *.ps1, *.bat -Recurse
    
    if ($Scripts.Count -eq 0) {
        Write-Warning "No scripts found in $($Category.Name)."
        Start-Sleep 2
        return
    }

    do {
        Show-Header
        Write-Host "Category: $($Category.Name)" -ForegroundColor Yellow
        Write-Host "Select a Script to Run:" -ForegroundColor Yellow
        
        $j = 1
        foreach ($Script in $Scripts) {
            Write-Host "  $j. $($Script.Name)" -ForegroundColor Cyan
            $j++
        }
        Write-Host "  B. Back"
        Write-Host ""

        $Selection = Read-Host "Choice"
        
        if ($Selection -eq "B") { return }
        
        if ($Selection -match "^\d+$" -and [int]$Selection -le $Scripts.Count) {
            $TargetScript = $Scripts[[int]$Selection - 1]
            Run-Script -ScriptPath $TargetScript.FullName
        }
    } until ($Selection -eq "B")
}

function Run-Script {
    param($ScriptPath)
    Write-Host "Launching $($ScriptPath)..." -ForegroundColor Green
    Start-Sleep 1
    
    if ($ScriptPath.EndsWith(".ps1")) {
        # Launch in new window to keep launcher alive
        Start-Process powershell.exe -ArgumentList "-NoExit", "-File `"$ScriptPath`""
    }
    elseif ($ScriptPath.EndsWith(".bat")) {
        Start-Process cmd.exe -ArgumentList "/k `"$ScriptPath`""
    }
}

# Main Loop
$Cats = Get-ScriptCategories

do {
    Show-CategoryMenu -Categories $Cats
    $MainChoice = Read-Host "Choice"
    
    if ($MainChoice -eq "Q") { exit }
    
    if ($MainChoice -match "^\d+$" -and [int]$MainChoice -le $Cats.Count) {
        Show-ScriptMenu -Category $Cats[[int]$MainChoice - 1]
    }
    
} until ($MainChoice -eq "Q")
