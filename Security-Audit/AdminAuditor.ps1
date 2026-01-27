<#
.SYNOPSIS
    Lists all users with local administrative privileges.

.DESCRIPTION
    Enumerates members of the local 'Administrators' group.
    Useful for security audits to detect unauthorized admins.

.NOTES
    Author: Ramon Luis Rios Jr. (Coqui Cloud)
#>

$Group = "Administrators"

Write-Host "--- Local Admin Audit ---" -ForegroundColor Cyan

try {
    # Try modern PowerShell command first
    $Members = Get-LocalGroupMember -Group $Group -ErrorAction Stop
    
    foreach ($Member in $Members) {
        Write-Host "User: $($Member.Name) | Type: $($Member.ObjectClass)" -ForegroundColor Red
    }
    Write-Host "Total Admins: $($Members.Count)" -ForegroundColor Gray

}
catch {
    # Fallback for legacy environments or domain issues
    Write-Warning "Get-LocalGroupMember failed. Using 'net localgroup'..."
    net localgroup $Group
}
