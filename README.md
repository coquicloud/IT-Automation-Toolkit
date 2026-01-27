# 🛠️ IT Automation & SysAdmin Toolkit

Welcome to the **Coqui Cloud IT Automation Toolkit**. This repository is a curated collection of PowerShell and Batch scripts designed to streamline system administration, enhance security auditing, and automate repetitive IT tasks.

## 📂 Repository Structure

- **/General-Maintenance**: Scripts for cleaning temp files, disk optimization, and system health checks.
- **/Network-Tools**: Connectivity testers, IP/MAC scanners, and port checkers.
- **/Security-Audit**: BitLocker status reports, Local Admin auditing, and permission monitors.
- **/Software-Management**: Bulk installers (Winget), update trackers, and software inventory.
- **/Active-Directory**: Stale account finders, user provisioning, and group membership reports.
- **/Backup-Recovery**: Automated file backups, registry exports, and recovery key management.

## 🚀 Featured Scripts

| Script Name | Language | Category | Description |
| :--- | :--- | :--- | :--- |
| **BulkInstaller.ps1** | PowerShell | Software | One-click installation of essential IT apps using Winget. |
| **SystemHealth.ps1** | PowerShell | Maintenance | Generates a real-time report on CPU, RAM, and Disk health. |
| **NetworkWatchdog.bat** | Batch | Network | Logs network drops with timestamps for ISP troubleshooting. |
| **StaleUserFinder.ps1** | PowerShell | AD | Identifies Active Directory accounts inactive for over 90 days. |
| **AdminAuditor.ps1** | PowerShell | Security | Lists all users with local administrative privileges. |
| **BitLockerExport.ps1** | PowerShell | Security | Exports BitLocker recovery keys to a central log. |
| **ServiceWatchdog.ps1** | PowerShell | Maintenance | Monitors and auto-restarts critical Windows services. |
| **DiskCleaner.ps1** | PowerShell | Maintenance | Deep cleans temp folders, prefetch, and system logs. |
| **RoboMigration.bat** | Batch | Backup | High-speed file migration with ACL preservation. |
| **SubnetScanner.ps1** | PowerShell | Network | Performs a fast ping sweep of the local subnet. |

## 🛠️ How to Use

1. **Clone the repository:**

   ```bash
   git clone https://github.com/RamonRios/IT-Automation-Toolkit.git
   ```

2. **Navigate to the desired category folder.**

3. **Execution:**
   - Most scripts require **Administrative Privileges**.
   - For PowerShell scripts, you may need to set your execution policy:

     ```powershell
     Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
     ```

---
*Maintained by: Ramon Rios @ Coqui Cloud Dev Co*
