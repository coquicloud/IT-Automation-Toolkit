<#
.SYNOPSIS
    Temporarily adds a user to the Local Admin group.
    
.DESCRIPTION
    Adds a user to Administrators and schedules a task to remove them after 1 hour.
    Requires Administrative privileges.
    
.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

Write-Host "--- Temporary Admin Access Granter ---" -ForegroundColor Cyan

# Validate User
if (-not (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue)) {
    Write-Error "User '$Username' not found."
    exit
}

# Add to Admin Group
Write-Host "Adding $Username to Administrators..." -ForegroundColor Yellow
Add-LocalGroupMember -Group "Administrators" -Member $Username

# Create Removal Task
$TaskName = "RemoveAdmin_$Username"
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-Command Remove-LocalGroupMember -Group Administrators -Member $Username; Unregister-ScheduledTask -TaskName '$TaskName' -Confirm:`$false"
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddHours(1)

Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -User "SYSTEM" -RunLevel Highest | Out-Null

Write-Host "SUCCESS: $Username is now an Admin for 60 minutes." -ForegroundColor Green
