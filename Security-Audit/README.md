# Security & Audit Tools

Scripts for auditing system security, user access, and USB activity.

## Scripts

### [AdminAuditor.ps1](AdminAuditor.ps1)

**Description:** Lists all users who are members of the local Administrators group on the machine.

### [BitLockerExport.ps1](BitLockerExport.ps1)

**Description:** Retrieves BitLocker recovery keys for all encrypted drives.
> [!CAUTION]
> **Security Risk:** Ensure the destination file is on a secure, encrypted drive or network share. Do not leave keys in cleartext on the same machine.

### [FirewallPortScanner.ps1](FirewallPortScanner.ps1)

**Description:** Checks the local Windows Firewall to see which ports are currently open or blocked.

### [LocalUserReset.ps1](LocalUserReset.ps1)

**Description:** Resets a local user account's password and unlocks the account if necessary.
**Usage:** Run as **Administrator**.

### [TempAdminAccess.ps1](TempAdminAccess.ps1)

**Description:** Grants a user temporary local admin rights for a set duration, then automatically removes them.
**Usage:** `.\TempAdminAccess.ps1 -Username "JohnDoe" -DurationHours 1`

### [UsbHistoryViewer.ps1](UsbHistoryViewer.ps1)

**Description:** Parses Windows Event Logs and Registry to show a history of USB storage devices connected to the system.

### [UsbPortLocker.ps1](UsbPortLocker.ps1)

**Description:** Disables or enables USB storage drivers to prevent data exfiltration.
> [!WARNING]
> This may disable non-storage USB devices depending on how the policy is applied. Test on a non-critical machine first.
