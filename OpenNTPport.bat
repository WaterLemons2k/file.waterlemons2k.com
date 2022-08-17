@echo off
::Get Administrator
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
) else (
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
::Open NTP port
netsh firewall add portopening UDP 123 "123UDP"
)