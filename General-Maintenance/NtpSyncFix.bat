@echo off
:: NTP Sync Fix - Resets Windows Time Service
:: Author: Ramon Luis Rios Jr. (Coqui Cloud)

echo ==============================================
echo       Windows Time Sync Fix
echo ==============================================

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Administrative privileges confirmed.
) else (
    echo Error: Please run as Administrator.
    pause
    exit
)

echo.
echo Stopping Windows Time Service...
net stop w32time

echo.
echo Unregistering w32time...
w32tm /unregister

echo.
echo Registering w32time...
w32tm /register

echo.
echo Starting Windows Time Service...
net start w32time

echo.
echo Forcing Sync with time.windows.com...
w32tm /config /manualpeerlist:"time.windows.com,0.us.pool.ntp.org" /syncfromflags:manual /reliable:YES /update
w32tm /resync

echo.
echo ==============================================
echo Time Sync Complete.
echo ==============================================
pause
