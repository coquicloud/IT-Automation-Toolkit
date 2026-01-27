<#
.SYNOPSIS
    Export/Import known WiFi Application profiles.
    
.DESCRIPTION
    Crucial for migrating users or field laptops to new hardware without losing 
    site credentials. Warning: Passwords are exported in clear text (xml).
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Export", "Import")]
    [string]$Mode,
    
    [string]$Path = "$env:UserProfile\Desktop\WiFiProfiles"
)

Write-Host "--- WiFi Profile Manager ---" -ForegroundColor Cyan

if ($Mode -eq "Export") {
    if (-not (Test-Path $Path)) { New-Item -ItemType Directory -Force -Path $Path | Out-Null }
    Write-Host "Exporting profiles to $Path..." -ForegroundColor Yellow
    netsh wlan export profile key=clear folder="$Path"
    Write-Host "Done." -ForegroundColor Green
}
elseif ($Mode -eq "Import") {
    if (-not (Test-Path $Path)) { Write-Error "Path not found: $Path"; exit }
    $Files = Get-ChildItem -Path $Path -Filter "*.xml"
    foreach ($File in $Files) {
        Write-Host "Importing $($File.Name)..." -ForegroundColor Yellow
        netsh wlan add profile filename="$($File.FullName)"
    }
    Write-Host "Done." -ForegroundColor Green
}
