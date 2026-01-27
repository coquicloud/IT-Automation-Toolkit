# 🛠️ IT Automation & SysAdmin Toolkit

Welcome to the **Coqui Cloud IT Automation Toolkit**. This repository is a curated collection of PowerShell and Batch scripts designed to streamline system administration, enhance security auditing, and automate repetitive IT tasks.

> **🆕 NEW! Unified Launcher**  
> Run `ToolkitLauncher.ps1` to access all scripts from a single menu interface!

## 📂 Repository Structure

- **/Active-Directory**: User management, stale account cleanup, and reporting.
- **/Backup-Recovery**: Driver exports, Robocopy migrations, and Shadow Copies.
- **/General-Maintenance**: System health, hardware auditing, and cleanup tools.
- **/Network-Tools**: WiFi profiles, IP monitoring, speed tests, and troubleshooting.
- **/Security-Audit**: Admin auditing, USB history, and port scanning.
- **/Software-Management**: Bulk installers (Winget/Choco) and Office repair tools.

## 🚀 Script Library

### 🔗 Network Tools

| Script | Description |
| :--- | :--- |
| `NetworkWatchdog.bat` | Logs ISP connectivity drops. |
| `SubnetScanner.ps1` | Fast ping sweep of local subnet. |
| `WiFiProfileBackup.ps1` | Export/Import WiFi credentials. |
| `PrinterAutoMapper.ps1` | Location-aware printer mapping. |
| `VpnClientReset.ps1` | Resets WAN miniport adapters & DNS. |
| `PublicIpMonitor.ps1` | Alerts on Public IP changes. |
| `NetworkSpeedTestCLI.ps1` | Command-line internet speed test. |
| `WakeOnLanTrigger.ps1` | Sends Magic Packets to wake PCs. |

### � General Maintenance

| Script | Description |
| :--- | :--- |
| `SystemHealth.ps1` | CPU, RAM, and Disk usage report. |
| `ServiceWatchdog.ps1` | Auto-restarts critical services. |
| `DiskCleaner.ps1` | Cleans temp files and logs. |
| `HardwareInfoDump.ps1` | Exports Serial, Model, BIOS to CSV. |
| `BatteryHealthCheck.ps1` | Battery health & degradation report. |
| `MonitorInputSwitch.ps1` | Toggles display inputs (Duplicate/Extend). |
| `NtpSyncFix.bat` | Resets Windows Time service. |
| `ClearPrintSpooler.bat` | Clears stuck print jobs. |
| `BlueScreenAnalyzer.ps1` | Analyzes minidump crash files. |
| `ProcessKiller.ps1` | Kills a process on remote computers. |
| `ProfileSizeReporter.ps1` | Reports size of user profiles. |

### 🔐 Security Audit

| Script | Description |
| :--- | :--- |
| `AdminAuditor.ps1` | Lists local administrators. |
| `BitLockerExport.ps1` | Exports recovery keys to CSV. |
| `UsbHistoryViewer.ps1` | Audits previously connected USB drives. |
| `TempAdminAccess.ps1` | Grants Admin rights for 1 hour. |
| `UsbPortLocker.ps1` | Sets USB ports to Read-Only mode. |
| `LocalUserReset.ps1` | Securely resets Admin password. |
| `FirewallPortScanner.ps1` | Checks for exposed dangerous ports. |

### 📦 Software Management

| Script | Description |
| :--- | :--- |
| `BulkInstaller.ps1` | Installs essential apps via Winget. |
| `ChocoAppsInstaller.ps1` | Installs legacy apps via Chocolatey. |
| `OfficeRepairTool.ps1` | Triggers Office Quick/Online Repair. |
| `OutlookProfileNuke.ps1` | Resets Outlook profile registry. |

### 💾 Backup & Recovery

| Script | Description |
| :--- | :--- |
| `RoboMigration.bat` | High-speed file migration (Robocopy). |
| `DriverBackup.ps1` | Exports all third-party drivers. |
| `ShadowCopyManager.ps1` | Manages VSS Snapshots (Restore Points). |
| `UptimeReport.ps1` | Reports last boot time (AD). |

## 🛠️ How to Use

1. **Clone the repository:**

   ```bash
   git clone https://github.com/RamonRios/IT-Automation-Toolkit.git
   ```

2. **Run the Launcher:**

   ```powershell
   .\ToolkitLauncher.ps1
   ```

   *Or navigate to specific folders to run individual scripts.*

3. **Execution Policy:**
   If scripts fail to run, enable execution:

   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

---
*Maintained by: Ramon Rios @ Coqui Cloud Dev Co*
