# Active Directory Tools

Scripts for managing AD users, computers, and infrastructure.

## Scripts

### [StaleUserFinder.ps1](StaleUserFinder.ps1)

**Description:** Identifies Active Directory accounts that have been inactive for a specified number of days (default 90).
> [!NOTE]
> **Prerequisite:** Requires the `ActiveDirectory` PowerShell module (RSAT).
**Usage:** `.\StaleUserFinder.ps1 -Days 90`

### [UptimeReport.ps1](UptimeReport.ps1)

**Description:** Generates a report of system uptime for a list of computers, helping identify servers that haven't been rebooted recently.
**Usage:** `.\UptimeReport.ps1`
> **Tip:** You can pipe a list of computer names: `Get-Content servers.txt | .\UptimeReport.ps1`
