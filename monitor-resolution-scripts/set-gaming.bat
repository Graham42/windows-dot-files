@echo off
:: Gaming Profile: Monitor 1 only at 4K with 200% scaling
:: Monitor 1 (left, DELL P2715Q): 3840x2160 @ 200%
:: Monitor 2 (right, LG HDR 4K): Disabled

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe
set MAIN=V7WP958B650L
set SECONDARY=008NTRL9A302

:: Disable Monitor 2 (right)
"%TOOL%" /disable "%SECONDARY%"

:: Set Monitor 1 to 4K landscape
"%TOOL%" /SetMonitors "Name=%MAIN% Width=3840 Height=2160"
"%TOOL%" /SetOrientation "%MAIN%" 0

:: Set Monitor 1 scaling to 200%
"%TOOL%" /SetScale "%MAIN%" 200

echo Gaming profile applied: Monitor 1 at 4K @ 200%%, Monitor 2 disabled
