# General Maintenance Tools

Routine maintenance scripts for system health and cleanup.

## Scripts

### [BatteryHealthCheck.ps1](BatteryHealthCheck.ps1)

**Description:** Generates a detailed battery health report (HTML) for laptops to check charge capacity and wear levels.
**Output:** Saves report to current directory as `BatteryReport.html`.

### [BlueScreenAnalyzer.ps1](BlueScreenAnalyzer.ps1)

**Description:** Scans memory dump files to provide a summary of recent Blue Screen of Death (BSOD) crashes.
> [!NOTE]
> Requires administrative privileges to read dump files in `C:\Windows\Minidump`.

### [ClearPrintSpooler.bat](ClearPrintSpooler.bat)

**Description:** Safely stops the print spooler, deletes stuck print jobs, and restarts the service.
> [!IMPORTANT]
> This will delete **all pending print jobs** on the system.

### [DiskCleaner.ps1](DiskCleaner.ps1)

**Description:** Automates Windows Disk Cleanup tools and clears temp folders to free up space.
> [!WARNING]
> **Irreversible:** Empties Recycle Bin, Temp folders, and System Logs.

### [HardwareInfoDump.ps1](HardwareInfoDump.ps1)

**Description:** Exports detailed system hardware specifications (CPU, RAM, Disk, Serial NuMbers) to a text or CSV file.

### [MonitorInputSwitch.ps1](MonitorInputSwitch.ps1)

**Description:** Utility to programmatically switch monitor inputs (DDC/CI), useful for KVM-like behavior via software.

### [NtpSyncFix.bat](NtpSyncFix.bat)

**Description:** Resets the Windows Time Service, re-registers DLLs, and forces a sync with time servers to fix clock drift.
**Usage:** Run as **Administrator**.

### [ProcessKiller.ps1](ProcessKiller.ps1)

**Description:** Quickly terminates memory-hogging or stuck processes by name or high CPU usage.
> [!CAUTION]
> Be careful when killing system processes. Save work before running.

### [ProfileSizeReporter.ps1](ProfileSizeReporter.ps1)

**Description:** Calculates and reports the size of all user profiles on the machine to identify space hogs.
**Usage:** `.\ProfileSizeReporter.ps1` (Run as Admin for accuracy)

### [ServiceWatchdog.ps1](ServiceWatchdog.ps1)

**Description:** Monitors specific critical services and automatically restarts them if they stop.

### [SystemHealth.ps1](SystemHealth.ps1)

**Description:** Runs a quick health check including disk space, SMART status, and core service availability.
