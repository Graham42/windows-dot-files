@echo off
:: Gaming Profile: Monitor 2 only at 4K with 200% scaling
:: Monitor 2 (left): 3840x2160 @ 200%
:: Monitor 1 (right): Disabled

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Disable Monitor 1 (right)
"%TOOL%" /disable \\.\DISPLAY1

:: Set Monitor 2 to 4K
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY2 Width=3840 Height=2160"

:: Set Monitor 2 scaling to 200%
"%TOOL%" /SetScale \\.\DISPLAY2 200

echo Gaming profile applied: Monitor 2 at 4K @ 200%%, Monitor 1 disabled
