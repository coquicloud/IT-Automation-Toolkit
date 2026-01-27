<#
.SYNOPSIS
    Kill a hung process on a list of remote computers.
    
.DESCRIPTION
    Reads a list of computers from a text file and kills the specified process.
    Requires WinRM/RPC access.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [string]$ProcessName = "chrome",
    [string]$ComputerListPath = "$env:UserProfile\Desktop\Computers.txt"
)

Write-Host "--- Process Killer ---" -ForegroundColor Cyan

if (-not (Test-Path $ComputerListPath)) {
    Write-Warning "Computer list not found at $ComputerListPath"
    Write-Host "Create a text file with one hostname per line."
    exit
}

$Computers = Get-Content $ComputerListPath

foreach ($PC in $Computers) {
    Write-Host "Checking $PC..." -NoNewline
    
    try {
        Invoke-Command -ComputerName $PC -ScriptBlock {
            param($Name)
            $Proc = Get-Process -Name $Name -ErrorAction SilentlyContinue
            if ($Proc) {
                Stop-Process -Name $Name -Force
                Write-Host " [KILLED $Name]" -ForegroundColor Green
            }
            else {
                Write-Host " [NOT FOUND]" -ForegroundColor Gray
            }
        } -ArgumentList $ProcessName -ErrorAction Stop
    }
    catch {
        Write-Host " [Unreachable]" -ForegroundColor Red
    }
}
