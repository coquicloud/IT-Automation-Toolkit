# Backup & Recovery Tools

Scripts for backing up drivers, files, and managing shadow copies.

## Scripts

### [DriverBackup.ps1](DriverBackup.ps1)

**Description:** Exports all third-party drivers from the current system to a backup folder.
> [!TIP]
> Run this **before** re-imaging a computer to easily restore drivers later.
**Usage:** `.\DriverBackup.ps1 -Destination "D:\Backups\Drivers"`

### [RoboMigration.bat](RoboMigration.bat)

**Description:** Robust file copy wrapper for Robocopy, optimized for large file server migrations with logging and resume capability.
**Usage:** `.\RoboMigration.bat [Source] [Destination]`
**Example:** `.\RoboMigration.bat "D:\Data" "\\NewServer\Share"`

### [ShadowCopyManager.ps1](ShadowCopyManager.ps1)

**Description:** Manages Volume Shadow Copies (VSS), allowing creation or deletion of snapshots for rollback purposes.
> [!WARNING]
> Deleting shadow copies prevents restoring previous versions of files. Use with caution.
**Usage:** `.\ShadowCopyManager.ps1 -Action Create -Drive "C:"`
