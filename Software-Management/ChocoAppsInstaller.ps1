<#
.SYNOPSIS
    Wrapper for Chocolatey to install legacy apps.
    
.DESCRIPTION
    Installs Chocolatey if missing, then installs a list of apps.
    Use this for apps NOT on Winget.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$Apps = @("googlechrome", "firefox", "vlc", "7zip", "notepadplusplus")

Write-Host "--- Chocolatey App Installer ---" -ForegroundColor Cyan

# Check for Choco
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

foreach ($App in $Apps) {
    Write-Host "Installing $App..." -ForegroundColor Yellow
    choco install $App -y
}

Write-Host "Done." -ForegroundColor Green
