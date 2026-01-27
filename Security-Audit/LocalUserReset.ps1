<#
.SYNOPSIS
    Securely resets the local 'Administrator' password to a random value.
    
.DESCRIPTION
    Generates a high-entropy password, sets it for the built-in Admin account,
    and logs the new credential to a secure file on the Desktop.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

function New-RandomPassword {
    return -join ((33..126) | Get-Random -Count 16 | ForEach-Object { [char]$_ })
}

$User = "Administrator"
$File = "$env:UserProfile\Desktop\NewAdminCreds.txt"

Write-Host "--- Local Admin Password Reset ---" -ForegroundColor Cyan

# Enable Account if disabled
try {
    Enable-LocalUser -Name $User -ErrorAction SilentlyContinue
    
    $NewPass = New-RandomPassword
    $SecurePass = ConvertTo-SecureString $NewPass -AsPlainText -Force
    
    Set-LocalUser -Name $User -Password $SecurePass
    
    Write-Host "Password for '$User' has been reset." -ForegroundColor Green
    
    $Content = "Hostname: $env:COMPUTERNAME`r`nUser: $User`r`nPassword: $NewPass`r`nDate: $(Get-Date)"
    Set-Content -Path $File -Value $Content
    
    Write-Host "Credentials saved to: $File" -ForegroundColor Yellow
}
catch {
    Write-Error "Failed to reset password. Check permissions."
}
