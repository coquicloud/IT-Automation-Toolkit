# Network Tools

Utilities for network diagnostics, configuration, and monitoring.

## Scripts

### [NetworkSpeedTestCLI.ps1](NetworkSpeedTestCLI.ps1)

**Description:** Runs a command-line internet speed test using standard APIs to verify bandwidth without a browser.

### [NetworkWatchdog.bat](NetworkWatchdog.bat)

**Description:** Continuously pings an external host (e.g. Google DNA) and logs outages or latency spikes to a file.
**Usage:** Keep the window open to monitor; close to stop.

### [PrinterAutoMapper.ps1](PrinterAutoMapper.ps1)

**Description:** Automatically maps network printers based on the user's subnet or AD group membership.
> [!TIP]
> Customize the mapping logic in the script to match your environment's printer names.

### [PublicIpMonitor.ps1](PublicIpMonitor.ps1)

**Description:** Checks and logs the external public IP address; alerts if it changes (useful for dynamic IP sites).

### [SubnetScanner.ps1](SubnetScanner.ps1)

**Description:** Scans a local subnet to identify active devices, resolving hostnames and MAC addresses where possible.
> [!NOTE]
> Some devices may block ICMP (Ping) requests and will not show up.

### [VpnClientReset.ps1](VpnClientReset.ps1)

**Description:** Resets specific VPN client adapters and services to resolve common connectivity issues.

### [WakeOnLanTrigger.ps1](WakeOnLanTrigger.ps1)

**Description:** Sends a Magic Packet to a specific MAC address to wake up a computer on the LAN.
**Usage:** `.\WakeOnLanTrigger.ps1 -MacAddress "AA-BB-CC-DD-EE-FF"`

### [WiFiProfileBackup.ps1](WiFiProfileBackup.ps1)

**Description:** Exports saved Wi-Fi profiles (SSIDs and keys) to XML files for backup.
**Usage:**

- **Backup:** `.\WiFiProfileBackup.ps1 -Export`
- **Restore:** `.\WiFiProfileBackup.ps1 -Import`
