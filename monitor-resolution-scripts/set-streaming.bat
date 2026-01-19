@echo off
:: Streaming Profile: Both monitors at 1440p
:: Monitor 1 (left): 2560x1440 @ 150%
:: Monitor 2 (right): 1440x2560 @ 100% (portrait)

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Ensure Monitor 2 is enabled
"%TOOL%" /enable \\.\DISPLAY2

:: Set Monitor 1 to 1440p landscape
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY1 Width=2560 Height=1440"
"%TOOL%" /SetOrientation \\.\DISPLAY1 0

:: Set Monitor 2 to 1440p portrait
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY2 Width=2560 Height=1440"
"%TOOL%" /SetOrientation \\.\DISPLAY2 90

:: Set scaling
"%TOOL%" /SetScale \\.\DISPLAY1 150
"%TOOL%" /SetScale \\.\DISPLAY2 100

echo Streaming profile applied: Both monitors at 1440p (150%% / 100%%)
