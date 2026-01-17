@echo off
:: Streaming Profile: Both monitors at 1440p
:: Monitor 2 (left): 2560x1440 @ 150%
:: Monitor 1 (right): 2560x1440 @ 100%

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Ensure Monitor 1 is enabled
"%TOOL%" /enable \\.\DISPLAY1

:: Set Monitor 2 to 1440p
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY2 Width=2560 Height=1440"

:: Set Monitor 1 to 1440p
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY1 Width=2560 Height=1440"

:: Set scaling
"%TOOL%" /SetScale \\.\DISPLAY2 150
"%TOOL%" /SetScale \\.\DISPLAY1 100

echo Streaming profile applied: Both monitors at 1440p (150%% / 100%%)
