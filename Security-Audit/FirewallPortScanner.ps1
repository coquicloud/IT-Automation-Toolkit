<#
.SYNOPSIS
    Checks if specific critical ports (RDP, SMB) are exposed to the public.
    
.DESCRIPTION
    Uses online port scanner API (viewdns.info proxy) or local netstat check.
    Here we implement a local check to see if ports are 'Listening' on 0.0.0.0.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$Ports = @(3389, 445, 21, 23, 8080)
Write-Host "--- Local Firewall Exposure Check ---" -ForegroundColor Cyan

$Connections = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue

foreach ($Port in $Ports) {
    if ($Connections | Where-Object { $_.LocalPort -eq $Port }) {
        Write-Host "[ALERT] Port $Port is OPEN/LISTENING!" -ForegroundColor Red
        
        # Check Firewall Rule
        $Rule = Get-NetFirewallRule | Where-Object { $_.Enabled -eq 'True' -and ($_.LocalPort -eq $Port -or $_.LocalPort -eq 'Any') -and $_.Direction -eq 'Inbound' } | Select-Object -First 1
        if ($Rule) {
            Write-Host "  -> Warning: Allowed by Firewall Rule '$($Rule.DisplayName)'" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "Port $Port is Closed/Not Listening." -ForegroundColor Green
    }
}
