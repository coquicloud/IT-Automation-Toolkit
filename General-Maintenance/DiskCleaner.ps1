<#
.SYNOPSIS
    Deep cleans temp folders, prefetch, and system logs.

.DESCRIPTION
    Removes temporary files from user profile and Windows system directories.
    Also clears Windows Event Logs to free up space (use with caution).
    Requires Admin privileges.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$Paths = @(
    "$env:TEMP",
    "$env:SystemRoot\Temp",
    "$env:SystemRoot\Prefetch"
)

Write-Host "--- Disk Cleaner Started ---" -ForegroundColor Cyan

# 1. Clean File Paths
foreach ($Path in $Paths) {
    if (Test-Path $Path) {
        Write-Host "Cleaning $Path..." -ForegroundColor Yellow
        try {
            Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        }
        catch {
            Write-Warning "Failed to clean some files in $Path."
        }
    }
}

# 2. Clear Event Logs
Write-Host "Cleaning Windows Event Logs..." -ForegroundColor Yellow
try {
    wevtutil el | ForEach-Object { 
        wevtutil cl "$_" 
    }
}
catch {
    Write-Warning "Could not clear event logs. Ensure you are running as Admin."
}

Write-Host "--- Cleanup Complete! ---" -ForegroundColor Green
