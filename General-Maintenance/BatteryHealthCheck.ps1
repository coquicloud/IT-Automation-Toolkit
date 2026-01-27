<#
.SYNOPSIS
    Generates a battery health report and parses degradation status.
    
.DESCRIPTION
    Runs 'powercfg /batteryreport' and opens it.
    Calculates current capacity vs design capacity.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$ReportPath = "$env:UserProfile\Desktop\battery-report.html"
$XmlPath = "$env:TEMP\battery-report.xml"

Write-Host "--- Battery Health Check ---" -ForegroundColor Cyan

# Generate standard HTML report
powercfg /batteryreport /output "$ReportPath" | Out-Null

# Generate XML for parsing (easier than HTML scraping)
powercfg /batteryreport /xml /output "$XmlPath" | Out-Null

if (Test-Path $XmlPath) {
    [xml]$BatteryXml = Get-Content $XmlPath
    
    try {
        $DesignCapacity = $BatteryXml.BatteryReport.Batteries.Battery.DesignCapacity
        $FullChargeCapacity = $BatteryXml.BatteryReport.Batteries.Battery.FullChargeCapacity
        
        if ($DesignCapacity -gt 0) {
            $HealthPercent = [math]::Round(($FullChargeCapacity / $DesignCapacity) * 100, 2)
            
            Write-Host "Design Capacity: $DesignCapacity mWh"
            Write-Host "Current Capacity: $FullChargeCapacity mWh"
            
            if ($HealthPercent -lt 70) {
                Write-Host "Battery Health: $HealthPercent% (REPLACE SOON)" -ForegroundColor Red
            }
            else {
                Write-Host "Battery Health: $HealthPercent% (GOOD)" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Warning "Could not parse battery XML details."
    }
    
    # Open full report
    Invoke-Item $ReportPath
}
else {
    Write-Warning "No battery detected (Is this a desktop?)."
}
