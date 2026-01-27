<#
.SYNOPSIS
    Generates a real-time report on CPU, RAM, and Disk health.

.DESCRIPTION
    Retrieves current CPU load, memory usage, and free disk space on the C: drive.
    Useful for quick health checks on servers or workstations.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function Get-SystemHealth {
    Write-Host "--- System Health Report ---" -ForegroundColor Cyan

    # CPU Load
    try {
        $Cpu = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
        Write-Host "CPU Usage: $Cpu%" -ForegroundColor ($Cpu -gt 80 ? "Red" : "Green")
    } catch {
        Write-Warning "Could not retrieve CPU usage."
    }

    # RAM Usage
    try {
        $Os = Get-CimInstance Win32_OperatingSystem
        $TotalRam = [math]::Round($Os.TotalVisibleMemorySize / 1KB, 2)
        $FreeRam = [math]::Round($Os.FreePhysicalMemory / 1KB, 2)
        $UsedRam = $TotalRam - $FreeRam
        $RamPercent = [math]::Round(($UsedRam / $TotalRam) * 100, 2)
        Write-Host "RAM Usage: $RamPercent% ($UsedRam MB / $TotalRam MB)" -ForegroundColor ($RamPercent -gt 80 ? "Red" : "Green")
    } catch {
        Write-Warning "Could not retrieve RAM usage."
    }

    # Disk Space (C:)
    try {
        $Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
        $FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
        $TotalSpaceGB = [math]::Round($Disk.Size / 1GB, 2)
        $DiskPercent = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100, 2)
        
        Write-Host "C: Drive: $FreeSpaceGB GB Free / $TotalSpaceGB GB Total" -ForegroundColor ($DiskPercent -lt 10 ? "Red" : "Green")
    } catch {
        Write-Warning "Could not retrieve Disk usage."
    }
}

Get-SystemHealth
