@echo off
:: Clear Print Spooler - Fixes stuck print jobs
:: Author: Ramon Luis Rios Jr. (Coqui Cloud)

echo ==============================================
echo       Print Spooler Reset
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
echo Stopping Print Spooler...
net stop spooler

echo.
echo Deleting stuck print jobs...
del /F /Q %systemroot%\System32\spool\PRINTERS\*.*

echo.
echo Restarting Print Spooler...
net start spooler

echo.
echo ==============================================
echo Spooler Cleared. Try printing again.
echo ==============================================
pause
