<#
.SYNOPSIS
    Calculates the size of every user profile in C:\Users.
    
.DESCRIPTION
    Helps identify disk space hogs.
    Iterates through directories, may require Admin for some folders.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function Get-FolderSize {
    param([string]$Path)
    try {
        $Size = Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
        return [math]::Round($Size.Sum / 1GB, 2)
    }
    catch {
        return 0
    }
}

Write-Host "--- User Profile Size Report ---" -ForegroundColor Cyan
Write-Host "Scanning C:\Users... (This takes time)" -ForegroundColor Gray

$Profiles = Get-ChildItem -Path "C:\Users" -Directory

foreach ($Profile in $Profiles) {
    if ($Profile.Name -notin @("Public", "Default", "All Users")) {
        $GB = Get-FolderSize -Path $Profile.FullName
        Write-Host "User: $($Profile.Name) - Size: ${GB} GB" -ForegroundColor ($GB -gt 10 ? "Red" : "Green")
    }
}

Write-Host "Done." -ForegroundColor Cyan
