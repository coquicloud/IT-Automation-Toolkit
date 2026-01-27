<#
.SYNOPSIS
    Performs a fast ping sweep of the local subnet.

.DESCRIPTION
    Pings all IP addresses in a given C-class subnet (e.g., 192.168.1.x)
    and reports which hosts are online.

.PARAMETER Subnet
    The subnet prefix (e.g., "192.168.1."). Note the trailing dot.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [string]$Subnet = "192.168.1."
)

Write-Host "--- Subnet Scanner Started ---" -ForegroundColor Cyan
Write-Host "Scanning range: ${Subnet}1 - ${Subnet}254" -ForegroundColor Gray

$OnlineHosts = @()

1..254 | ForEach-Object {
    $IP = "$Subnet$_"
    # Show progress in the title bar or write-progress
    Write-Progress -Activity "Scanning Subnet" -Status "Pinging $IP" -PercentComplete (($_ / 254) * 100)

    if (Test-Connection -ComputerName $IP -Count 1 -Quiet) {
        Write-Host "[UP]   $IP" -ForegroundColor Green
        $OnlineHosts += $IP
    }
}

Write-Host "`n--- Scan Complete ---" -ForegroundColor Cyan
Write-Host "Found $($OnlineHosts.Count) active hosts."
