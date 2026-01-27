<#
.SYNOPSIS
    Runs a connection speed test (approximate) by downloading a test file.
    
.DESCRIPTION
    Does not require external binaries like Ookla, uses standard .NET web client.
    Downloads a 100MB file from a CDN to calculate throughput.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$TestUrl = "http://speedtest.tele2.net/100MB.zip" # Common speedtest file
$TempFile = "$env:TEMP\speedtest.tmp"

Write-Host "--- Network Speed Test (Downloader) ---" -ForegroundColor Cyan
Write-Host "Target: $TestUrl" -ForegroundColor Gray

try {
    $WebClient = New-Object System.Net.WebClient
    $Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    Write-Host "Downloading..." -NoNewline
    $WebClient.DownloadFile($TestUrl, $TempFile)
    
    $Stopwatch.Stop()
    Write-Host " Done!" -ForegroundColor Green
    
    $FileSizeMB = 100
    $TimeSeconds = $Stopwatch.Elapsed.TotalSeconds
    $SpeedMbps = ($FileSizeMB * 8) / $TimeSeconds
    
    Write-Host "Time: $([math]::Round($TimeSeconds, 2)) seconds"
    Write-Host "Speed: $([math]::Round($SpeedMbps, 2)) Mbps" -ForegroundColor Magenta
    
    Remove-Item $TempFile -Force
}
catch {
    Write-Error "Speed test failed. Internet may be down."
}
