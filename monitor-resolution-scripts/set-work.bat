@echo off
:: Work Profile: Monitor 1 at 4K, Monitor 2 at 1440p portrait
:: Monitor 1 (left): 3840x2160 @ 175%
:: Monitor 2 (right): 1440x2560 @ 100% (portrait)

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Ensure Monitor 2 is enabled
"%TOOL%" /enable \\.\DISPLAY2

:: Set Monitor 1 to 4K landscape
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY1 Width=3840 Height=2160"
"%TOOL%" /SetOrientation \\.\DISPLAY1 0

:: Set Monitor 2 to 1440p portrait
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY2 Width=2560 Height=1440"
"%TOOL%" /SetOrientation \\.\DISPLAY2 90

:: Set scaling
"%TOOL%" /SetScale \\.\DISPLAY1 175
"%TOOL%" /SetScale \\.\DISPLAY2 100

echo Work profile applied: Monitor 1 at 4K @ 175%%, Monitor 2 at 1440p portrait @ 100%%
