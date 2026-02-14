@echo off
:: Work Profile: Monitor 1 at 4K, Monitor 2 at 1440p portrait
:: Monitor 1 (left, DELL P2715Q): 3840x2160 @ 175%
:: Monitor 2 (right, LG HDR 4K): 1440x2560 @ 100% (portrait)

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe
set MAIN=V7WP958B650L
set SECONDARY=008NTRL9A302

:: Ensure Monitor 2 is enabled
"%TOOL%" /enable "%SECONDARY%"

:: Set Monitor 1 to 4K landscape
"%TOOL%" /SetMonitors "Name=%MAIN% Width=3840 Height=2160"
"%TOOL%" /SetOrientation "%MAIN%" 0

:: Set Monitor 2 to 1440p portrait
"%TOOL%" /SetMonitors "Name=%SECONDARY% Width=2560 Height=1440"
"%TOOL%" /SetOrientation "%SECONDARY%" 90

:: Set scaling
"%TOOL%" /SetScale "%MAIN%" 175
"%TOOL%" /SetScale "%SECONDARY%" 100

echo Work profile applied: Monitor 1 at 4K @ 175%%, Monitor 2 at 1440p portrait @ 100%%
