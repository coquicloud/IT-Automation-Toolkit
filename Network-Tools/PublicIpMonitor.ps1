<#
.SYNOPSIS
    Checks the public IP address at intervals and alerts if it changes.
    
.DESCRIPTION
    Useful for sites without static IPs to detect changes.
    Logs to a file on Desktop.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$LogFile = "$env:UserProfile\Desktop\PublicIpLog.txt"
$IntervalSeconds = 300 # 5 Minutes

Write-Host "--- Public IP Monitor ---" -ForegroundColor Cyan
Write-Host "Monitoring every $IntervalSeconds seconds..."

$LastIP = "Unknown"

while ($true) {
    try {
        $CurrentIP = (Invoke-RestMethod "https://api.ipify.org")
        $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        if ($CurrentIP -ne $LastIP) {
            $Msg = "[$Timestamp] IP CHANGED: $LastIP -> $CurrentIP"
            Write-Host $Msg -ForegroundColor Red
            Add-Content -Path $LogFile -Value $Msg
            $LastIP = $CurrentIP
        }
        else {
            Write-Host "[$Timestamp] IP Stable: $CurrentIP" -ForegroundColor DarkGray
        }
    }
    catch {
        Write-Warning "Failed to check IP. Retrying..."
    }
    
    Start-Sleep -Seconds $IntervalSeconds
}
