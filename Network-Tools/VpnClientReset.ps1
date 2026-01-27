<#
.SYNOPSIS
    Resets WAN miniport adapters and flushes DNS to fix generic connection issues.
    
.DESCRIPTION
    Often fixes "VPN connecting..." hangs or "Limited Connectivity" issues
    by refreshing network stack components.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

Write-Host "--- VPN Client Reset ---" -ForegroundColor Cyan

# DNS Flush
Write-Host "Flushing DNS..." -ForegroundColor Yellow
Clear-DnsClientCache
ipconfig /flushdns

# Reset Winsock
Write-Host "Resetting Winsock catalog..." -ForegroundColor Yellow
netsh winsock reset

# Reset IP
Write-Host "Resetting IP stack..." -ForegroundColor Yellow
netsh int ip reset

# Specific device reset (Optional - requires PnPUtil or DevCon, simulating via netsh)
Write-Host "Refreshing network adapters..." -ForegroundColor Yellow
Get-NetAdapter | Restart-NetAdapter

Write-Host "Reset complete. Please RESTART your computer." -ForegroundColor Green
