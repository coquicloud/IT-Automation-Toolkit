@echo off
:: Network Watchdog - Logs connectivity drops
:: Author: Ramon Luis Rios Jr. (Coqui Cloud)

title Network Watchdog
echo ==============================================
echo       Network Connectivity Monitor
echo ==============================================
echo Monitoring connectivity to 8.8.8.8 (Google DNS)...
echo Log file: %UserProfile%\Desktop\NetworkLog.txt
echo.
echo [Press Ctrl+C to Stop]
echo.

:LOOP
ping 8.8.8.8 -n 1 >nul
if errorlevel 1 (
    echo [DISCONNECTED] %date% %time%
    echo [DISCONNECTED] %date% %time% >> "%UserProfile%\Desktop\NetworkLog.txt"
    color 4C
) else (
    :: Connection OK - Reset color to Green on Black
    color 0A
)

:: Wait 5 seconds before next check
timeout /t 5 >nul
goto LOOP
