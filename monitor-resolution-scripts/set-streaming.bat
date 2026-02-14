@echo off
:: Streaming Profile: Both monitors at 1440p
:: Monitor 1 (left, DELL P2715Q): 2560x1440 @ 150%
:: Monitor 2 (right, LG HDR 4K): 1440x2560 @ 100% (portrait)

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe
set MAIN=V7WP958B650L
set SECONDARY=008NTRL9A302

:: Ensure Monitor 2 is enabled
"%TOOL%" /enable "%SECONDARY%"

:: Set Monitor 1 to 1440p landscape
"%TOOL%" /SetMonitors "Name=%MAIN% Width=2560 Height=1440"
"%TOOL%" /SetOrientation "%MAIN%" 0

:: Set Monitor 2 to 1440p portrait
"%TOOL%" /SetMonitors "Name=%SECONDARY% Width=2560 Height=1440"
"%TOOL%" /SetOrientation "%SECONDARY%" 90

:: Set scaling
"%TOOL%" /SetScale "%MAIN%" 150
"%TOOL%" /SetScale "%SECONDARY%" 100

echo Streaming profile applied: Both monitors at 1440p (150%% / 100%%)
