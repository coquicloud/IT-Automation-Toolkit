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

## 📂 Categories

Click on a category to view the list of available scripts and their documentation.

### 🔗 [Network Tools](./Network-Tools/README.md)

Diagnostics, WiFi management, and connectivity monitoring.

### 🛠️ [General Maintenance](./General-Maintenance/README.md)

System health checks, hardware auditing, and cleanup tools.

### 🔐 [Security Audit](./Security-Audit/README.md)

Admin auditing, USB history, and port scanning.

### 📦 [Software Management](./Software-Management/README.md)

Bulk installers (Winget/Choco) and Office repair tools.

### 💾 [Backup & Recovery](./Backup-Recovery/README.md)

Driver exports, file migration, and Shadow Copies.

### 👥 [Active Directory](./Active-Directory/README.md)

User management and AD reporting.

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
