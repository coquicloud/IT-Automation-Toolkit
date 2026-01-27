<#
.SYNOPSIS
    Reports last boot time for computers in an Active Directory OU.
    
.DESCRIPTION
    Finds workstations that haven't rebooted in >30 days.
    Requires ActiveDirectory module.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

Write-Host "--- Domain Uptime Report ---" -ForegroundColor Cyan

try {
    Import-Module ActiveDirectory -ErrorAction Stop
}
catch {
    Write-Error "ActiveDirectory module not found."
    exit
}

$Computers = Get-ADComputer -Filter * -Properties LastLogonDate, OperatingSystem
$Today = Get-Date

foreach ($PC in $Computers) {
    try {
        $Wmi = Get-CimInstance Win32_OperatingSystem -ComputerName $PC.Name -ErrorAction Stop
        $BootTime = $Wmi.LastBootUpTime
        $UptimeDays = ($Today - $BootTime).Days
        
        Write-Host "$($PC.Name): Uptime $UptimeDays days" -ForegroundColor ($UptimeDays -gt 30 ? "Red" : "Green")
        
    }
    catch {
        Write-Warning "Could not query $($PC.Name) (Offline?)"
    }
}
