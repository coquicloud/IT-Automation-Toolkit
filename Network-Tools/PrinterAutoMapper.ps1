<#
.SYNOPSIS
    Automatically map nearby printers based on the current Gateway or Subnet.
    
.DESCRIPTION
    Location-aware printing script. Detects subnet and maps specific shared printers.
    Edit the $PrinterMap dictionary to match your environment.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$PrinterMap = @{
    "192.168.1.1" = "\\PrintServer\HQ-Main-Copier"
    "10.0.5.1"    = "\\PrintServer\Branch-Office-Printer"
}

Write-Host "--- Printer Auto Mapper ---" -ForegroundColor Cyan

# Get Default Gateway
$Gateway = (Get-NetRoute | Where-Object { $_.DestinationPrefix -eq "0.0.0.0/0" } | Select-Object -First 1).NextHop

Write-Host "Detected Gateway: $Gateway" -ForegroundColor Gray

if ($PrinterMap.ContainsKey($Gateway)) {
    $PrinterPath = $PrinterMap[$Gateway]
    Write-Host "Location recognized. Mapping: $PrinterPath" -ForegroundColor Yellow
    try {
        Add-Printer -ConnectionName $PrinterPath
        Write-Host "Printer mapped successfully." -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to map printer. Ensure print server is reachable."
    }
}
else {
    Write-Warning "No printers configured for this location ($Gateway)."
}
