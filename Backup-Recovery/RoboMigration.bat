@echo off
:: RoboMigration - High-performance file copy
:: Author: Ramon Luis Rios Jr. (Coqui Cloud)

echo.
echo "    ____       __           __  ____                  __  _            "
echo "   / __ \____ / /_  ____   /  |/  (_)___ __________ _/ /_(_)___  ____  "
echo "  / /_/ / __ \/ __ \/ __ \ / /|_/ / / __ `/ ___/ __ `/ __/ / __ \/ __ \ "
echo " / _, _/ /_/ / /_/ / /_/ // /  / / / /_/ / /  / /_/ / /_/ / /_/ / / / / "
echo "/_/ |_|\____/_.___/\____//_/  /_/_/\__, /_/   \__,_/\__/_/\____/_/ /_/  "
echo "                                  /____/                                "
echo.

set /p SOURCE="Enter Source Path (e.g., D:\Data): "
set /p DEST="Enter Destination Path (e.g., E:\Backup): "

if not exist "%SOURCE%" (
    echo Error: Source path does not exist.
    pause
    exit /b
)

echo.
echo ============================================
echo Starting Migration...
echo FROM: %SOURCE%
echo TO:   %DEST%
echo ============================================
echo.
echo Press any key to confirm and start...
pause >nul

:: Flags Explained:
:: /MIR     : Mirror directory tree (purge files not in source)
:: /COPY:DAT: Copy Data, Attributes, Timestamps (Add SO for Security/Owner if needed)
:: /MT:32   : Multi-threaded (32 threads) - High speed
:: /R:3     : Retry 3 times
:: /W:1     : Wait 1 second between retries
:: /TEE     : Output to console and log file
:: /LOG     : Log file path

robocopy "%SOURCE%" "%DEST%" /MIR /COPY:DAT /MT:32 /R:3 /W:1 /LOG:"%UserProfile%\Desktop\MigrationLog.txt" /TEE

echo.
echo ============================================
echo Migration Complete.
echo Log saved to %UserProfile%\Desktop\MigrationLog.txt
echo ============================================
pause
