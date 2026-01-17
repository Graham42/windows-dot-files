@echo off
:: Work Profile: Monitor 2 at 4K, Monitor 1 at 1440p
:: Monitor 2 (left): 3840x2160 @ 200%
:: Monitor 1 (right): 2560x1440 @ 100%

set TOOL=%~dp0multimonitortool-x64\MultiMonitorTool.exe

:: Ensure Monitor 1 is enabled
"%TOOL%" /enable \\.\DISPLAY1

:: Set Monitor 2 to 4K
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY2 Width=3840 Height=2160"

:: Set Monitor 1 to 1440p
"%TOOL%" /SetMonitors "Name=\\.\DISPLAY1 Width=2560 Height=1440"

:: Set scaling
"%TOOL%" /SetScale \\.\DISPLAY2 175
"%TOOL%" /SetScale \\.\DISPLAY1 100

echo Work profile applied: Monitor 2 at 4K @ 175%%, Monitor 1 at 1440p @ 100%%
