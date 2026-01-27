# Software Management Tools

Scripts for installing, updating, and repairing software.

## Scripts

### [BulkInstaller.ps1](BulkInstaller.ps1)

**Description:** Reads a list of software IDs (e.g. from Winget) from a text file and silently installs them.
**Usage:** `.\BulkInstaller.ps1 -List "AppsToInstall.txt"`
> [!TIP]
> Create a text file with one Winget ID per line (e.g., `Google.Chrome`, `7zip.7zip`).

### [ChocoAppsInstaller.ps1](ChocoAppsInstaller.ps1)

**Description:** Bootstraps the Chocolatey package manager and installs a standard suite of apps.
**Note:** Requires an internet connection and Admin rights.

### [OfficeRepairTool.ps1](OfficeRepairTool.ps1)

**Description:** Initiates Quick or Online Repair for Microsoft Office 365 installations to fix common crashes.
**Usage:**

- Quick Repair (Fast, no internet): `.\OfficeRepairTool.ps1 -Mode Quick`
- Online Repair (Thorough, re-downloads files): `.\OfficeRepairTool.ps1 -Mode Online`

### [OutlookProfileNuke.ps1](OutlookProfileNuke.ps1)

**Description:** Deletes the existing Outlook mail profile to force a clean setup on the next launch.
> [!WARNING]
> **Data Impact:** This deletes the profile registry key. The user will need to sign in again, and the OST file (local cache) will be redownloaded.
