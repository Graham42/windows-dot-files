@echo off
:: Gaming Profile: Monitor 1 only at 4K with 200% scaling
:: Monitor 1 (left): 3840x2160 @ 200%
:: Monitor 2 (right): Disabled

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Disable Monitor 2 (right)
"%TOOL%" /disable \\.\DISPLAY2

:: Set Monitor 1 to 4K landscape
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY1 Width=3840 Height=2160"
"%TOOL%" /SetOrientation \\.\DISPLAY1 0

:: Set Monitor 1 scaling to 200%
"%TOOL%" /SetScale \\.\DISPLAY1 200

echo Gaming profile applied: Monitor 1 at 4K @ 200%%, Monitor 2 disabled
