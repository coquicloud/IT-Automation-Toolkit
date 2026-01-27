<#
.SYNOPSIS
    Basic analysis of driver crashes (BSOD).
    
.DESCRIPTION
    Scans C:\Windows\Minidump.
    Can attempt to run debug tools if installed, otherwise lists latest dumps.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$DumpPath = "C:\Windows\Minidump"

Write-Host "--- Blue Screen (BSOD) Analyzer ---" -ForegroundColor Cyan

if (Test-Path $DumpPath) {
    $Dumps = Get-ChildItem -Path $DumpPath | Sort-Object LastWriteTime -Descending
    
    if ($Dumps) {
        Write-Host "Found $($Dumps.Count) crash dump(s):" -ForegroundColor Yellow
        $Dumps | Select-Object Name, CreationTime, Length | Format-Table -AutoSize
        
        Write-Host "Note: To deeply analyze these files, install WinDbg Preview from the Microsoft Store." -ForegroundColor Gray
    }
    else {
        Write-Host "No crash dumps found. System appears stable." -ForegroundColor Green
    }
}
else {
    Write-Warning "Minidump folder not found. (Not enabled or no crashes yet)"
}
