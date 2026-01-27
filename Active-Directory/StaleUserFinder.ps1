<#
.SYNOPSIS
    Identifies Active Directory accounts inactive for over 90 days.

.DESCRIPTION
    Queries Active Directory for users who haven't logged on in the specified
    number of days. Requires the ActiveDirectory PowerShell module.

.PARAMETER Days
    Number of days to check for inactivity. Default is 90.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param (
    [int]$Days = 90
)

Write-Host "--- Stale User Finder ---" -ForegroundColor Cyan
Write-Host "Searching for accounts inactive for more than $Days days..." -ForegroundColor Gray

try {
    # Check for AD Module
    if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
        throw "ActiveDirectory module is not installed. Please install RSAT."
    }
    Import-Module ActiveDirectory -ErrorAction Stop

    $ThresholdDate = (Get-Date).AddDays(-$Days)
    
    # Find users
    $StaleUsers = Get-ADUser -Filter { LastLogonDate -lt $ThresholdDate -and Enabled -eq $true } -Properties LastLogonDate | 
    Select-Object Name, SamAccountName, LastLogonDate, DistinguishedName
    
    if ($StaleUsers) {
        $StaleUsers | Format-Table -AutoSize
        Write-Host "Found $($StaleUsers.Count) stale accounts." -ForegroundColor Red
        
        # Optional: Export to CSV
        # $StaleUsers | Export-Csv -Path "$env:UserProfile\Desktop\StaleUsers.csv" -NoTypeInformation
    }
    else {
        Write-Host "No stale accounts found." -ForegroundColor Green
    }

}
catch {
    Write-Warning "Error: $($_.Exception.Message)"
    Write-Warning "Ensure you are connected to the specific domain network and have RSAT installed."
}
