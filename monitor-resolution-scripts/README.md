Download tool from https://www.nirsoft.net/utils/multi_monitor_tool.html and extract here

## Monitor Identification

The scripts use monitor **serial numbers** instead of display names (e.g., `\\.\DISPLAY1`). Display names can change depending on which monitor Windows detects first during boot, causing settings to be applied to the wrong monitor.

Serial numbers are unique to each physical monitor and remain stable regardless of detection order.

## Finding Serial Numbers

If you replace a monitor, you'll need to update the serial numbers in the scripts. To get monitor info:

```cmd
multimonitortool-x64\MultiMonitorTool.exe /scomma monitors.csv
type monitors.csv
```

Then update the `MAIN` and `SECONDARY` variables at the top of each script.

## Syntax Note

MultiMonitorTool uses different syntax for serial numbers depending on the command:

- `/SetMonitors` → requires `Name=` prefix: `"Name=%MAIN% Width=3840 Height=2160"`
- Other commands (`/enable`, `/disable`, `/SetOrientation`, `/SetScale`) → use serial number directly: `"%MAIN%"`
