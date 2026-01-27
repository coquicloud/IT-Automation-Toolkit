<#
.SYNOPSIS
    Monitors and auto-restarts critical Windows services.

.DESCRIPTION
    Checks a list of services (e.g., Spooler, Windows Update). If any are stopped,
    it attempts to restart them and logs the action to host.
    
.PARAMETER Services
    List of service names to monitor. Default is Spooler and wuauserv.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param (
    [string[]]$Services = @("Spooler", "wuauserv")
)

Write-Host "--- Service Watchdog Started ---" -ForegroundColor Cyan

foreach ($Service in $Services) {
    try {
        $ServiceStatus = Get-Service -Name $Service -ErrorAction Stop
        
        if ($ServiceStatus.Status -ne 'Running') {
            Write-Host "ALERT: Service '$Service' is $($ServiceStatus.Status). Attempting restart..." -ForegroundColor Red
            Start-Service -Name $Service
            
            # Verify restart
            $NewStatus = Get-Service -Name $Service
            if ($NewStatus.Status -eq 'Running') {
                Write-Host "SUCCESS: Service '$Service' is now running." -ForegroundColor Green
            } else {
                Write-Host "ERROR: Failed to restart '$Service'." -ForegroundColor Red
            }
        } else {
            Write-Host "OK: Service '$Service' is running." -ForegroundColor Green
        }
    } catch {
        Write-Warning "Service '$Service' not found on this system."
    }
}
