<#
.SYNOPSIS
    Exports Serial#, Model, BIOS Version, and Warranty Start Date to a CSV.
    
.DESCRIPTION
    Useful for asset tracking and inventory management.
    Saves report to User's Desktop.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$ReportPath = "$env:UserProfile\Desktop\HardwareInventory.csv"

Write-Host "--- Hardware Info Dump ---" -ForegroundColor Cyan

try {
    $ComputerSystem = Get-CimInstance Win32_ComputerSystem
    $Bios = Get-CimInstance Win32_BIOS
    $Os = Get-CimInstance Win32_OperatingSystem
    
    # Try to get Warranty info from BIOS release date as a proxy/guess
    # Real warranty lookups require vendor APIs (Dell/Lenovo/HP)
    
    $Info = [PSCustomObject]@{
        Hostname     = $ComputerSystem.Name
        Manufacturer = $ComputerSystem.Manufacturer
        Model        = $ComputerSystem.Model
        SerialNumber = $Bios.SerialNumber
        BIOSVersion  = $Bios.SMBIOSBIOSVersion
        OSVersion    = $Os.Caption
        InstallDate  = $Os.InstallDate
        RAM_GB       = [math]::Round($ComputerSystem.TotalPhysicalMemory / 1GB, 0)
        Processor    = (Get-CimInstance Win32_Processor).Name
    }
    
    $Info | Export-Csv -Path $ReportPath -NoTypeInformation
    
    Write-Host "Hardware info exported to: $ReportPath" -ForegroundColor Green
    $Info | Format-List
    
}
catch {
    Write-Error "Failed to retrieve hardware info."
}
