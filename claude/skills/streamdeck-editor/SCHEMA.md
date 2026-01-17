# Stream Deck JSON Schema Reference

Complete JSON schema documentation for Stream Deck profile files.

## Directory Structure

```
%APPDATA%\Elgato\StreamDeck\
├── ProfilesV2/                    # All user profiles
│   └── {GUID}.sdProfile/          # Profile bundle (directory)
│       ├── manifest.json          # Bundle metadata
│       ├── Images/                # Shared images (optional)
│       └── Profiles/              # Pages in this profile
│           └── {PageID}/          # Page directory
│               ├── manifest.json  # Page actions
│               └── Images/        # Button icons
├── Plugins/                       # Installed plugins
├── Audio/                         # Soundboard files
├── IconPacks/                     # Custom icon packs
└── Backup/                        # Profile backups
```

## Profile Bundle Manifest

**Location:** `{GUID}.sdProfile/manifest.json`

```json
{
  "AppIdentifier": "*",
  "Device": {
    "Model": "20GAT9902",
    "UUID": "@(1)[4057/143/SERIALNUMBER]"
  },
  "Name": "My Profile Name",
  "Pages": {
    "Current": "uuid-of-current-page",
    "Default": "uuid-of-default-page",
    "Pages": ["uuid-page-1", "uuid-page-2"]
  },
  "Version": "2.0"
}
```

### Field Descriptions

| Field           | Type   | Description                                           |
| --------------- | ------ | ----------------------------------------------------- |
| `AppIdentifier` | string | `"*"` for all apps, or specific app bundle ID         |
| `Device.Model`  | string | Hardware model ID (e.g., `"20GAT9902"`)               |
| `Device.UUID`   | string | Device serial in format `@(1)[vendor/product/serial]` |
| `Name`          | string | Display name of the profile                           |
| `Pages.Current` | UUID   | Currently active page                                 |
| `Pages.Default` | UUID   | Page shown when profile loads                         |
| `Pages.Pages`   | UUID[] | Array of all page UUIDs in this profile               |
| `Version`       | string | Always `"2.0"`                                        |

### Device Model IDs

| Model ID    | Device                        |
| ----------- | ----------------------------- |
| `20GAT9901` | Stream Deck Mini              |
| `20GAT9902` | Stream Deck (Standard 15-key) |
| `20GAT9903` | Stream Deck XL                |
| `20GAA9901` | Stream Deck Mobile            |
| `20GAV9901` | Stream Deck +                 |

## Page Manifest

**Location:** `{GUID}.sdProfile/Profiles/{PageID}/manifest.json`

```json
{
  "Controllers": [
    {
      "Actions": {
        "0,0": {
          /* Action object */
        },
        "1,0": {
          /* Action object */
        },
        "0,1": {
          /* Action object */
        }
      },
      "Type": "Keypad"
    }
  ],
  "Icon": "",
  "Name": "Page Name"
}
```

### Field Descriptions

| Field                   | Type   | Description                                 |
| ----------------------- | ------ | ------------------------------------------- |
| `Controllers`           | array  | Array of controller configs (typically 1)   |
| `Controllers[].Type`    | string | Always `"Keypad"` for button grid           |
| `Controllers[].Actions` | object | Keys are `"X,Y"` coords, values are actions |
| `Icon`                  | string | Optional page icon path                     |
| `Name`                  | string | Optional page display name                  |

### Button Coordinate System

Coordinates are `"column,row"` strings (0-indexed from top-left):

**Stream Deck Standard (15 keys):**

```
"0,0" "1,0" "2,0" "3,0" "4,0"
"0,1" "1,1" "2,1" "3,1" "4,1"
"0,2" "1,2" "2,2" "3,2" "4,2"
```

**Stream Deck XL (32 keys):**

```
"0,0" "1,0" "2,0" "3,0" "4,0" "5,0" "6,0" "7,0"
"0,1" "1,1" "2,1" "3,1" "4,1" "5,1" "6,1" "7,1"
"0,2" "1,2" "2,2" "3,2" "4,2" "5,2" "6,2" "7,2"
"0,3" "1,3" "2,3" "3,3" "4,3" "5,3" "6,3" "7,3"
```

**Stream Deck Mini (6 keys):**

```
"0,0" "1,0" "2,0"
"0,1" "1,1" "2,1"
```

## Action Object Schema

```json
{
  "ActionID": "550e8400-e29b-41d4-a716-446655440000",
  "LinkedTitle": true,
  "Name": "Action Display Name",
  "UUID": "com.elgato.streamdeck.system.website",
  "Settings": {},
  "State": 0,
  "States": [
    {
      "Title": "Button Text",
      "Image": "Images/icon.png",
      "FontFamily": "",
      "FontSize": 9,
      "FontStyle": "",
      "FontUnderline": false,
      "OutlineThickness": 2,
      "ShowTitle": true,
      "TitleAlignment": "bottom",
      "TitleColor": "#ffffff"
    }
  ]
}
```

### Action Field Descriptions

| Field         | Type    | Required | Description                                                           |
| ------------- | ------- | -------- | --------------------------------------------------------------------- |
| `ActionID`    | UUID    | Yes      | Unique identifier for this button instance                            |
| `LinkedTitle` | boolean | Yes      | `true` = all states share title; `false` = each state has own title   |
| `Name`        | string  | Yes      | Human-readable action type name                                       |
| `UUID`        | string  | Yes      | Action type identifier (e.g., `com.elgato.streamdeck.system.website`) |
| `Settings`    | object  | Yes      | Action-specific configuration (can be empty `{}`)                     |
| `State`       | integer | Yes      | Current active state index (0-based)                                  |
| `States`      | array   | Yes      | Array of state display configurations                                 |

### State Object Fields

| Field              | Type    | Default     | Description                                           |
| ------------------ | ------- | ----------- | ----------------------------------------------------- |
| `Title`            | string  | `""`        | Text displayed on button (supports `\n` for newlines) |
| `Image`            | string  | `""`        | Relative path to icon (e.g., `"Images/icon.png"`)     |
| `FontFamily`       | string  | `""`        | Font name (empty = system default)                    |
| `FontSize`         | integer | `9`         | Font size in points (6-40)                            |
| `FontStyle`        | string  | `""`        | `""`, `"Bold"`, `"Italic"`, `"Bold Italic"`           |
| `FontUnderline`    | boolean | `false`     | Underline text                                        |
| `OutlineThickness` | integer | `2`         | Text outline width (0-3)                              |
| `ShowTitle`        | boolean | `true`      | Display title text on button                          |
| `TitleAlignment`   | string  | `"bottom"`  | `"top"`, `"middle"`, `"bottom"`                       |
| `TitleColor`       | string  | `"#ffffff"` | Hex color code                                        |

## Multi-Action Schema

Multi-actions execute a sequence of actions:

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Multi Action",
  "UUID": "com.elgato.streamdeck.multiactions.routine",
  "Settings": {},
  "State": 0,
  "States": [{ "Title": "Do Stuff" }],
  "Actions": [
    {
      "Actions": [
        {
          "ActionID": "inner-uuid-1",
          "LinkedTitle": true,
          "Name": "Open",
          "UUID": "com.elgato.streamdeck.system.open",
          "Settings": { "path": "\"C:\\App.exe\"" },
          "State": 0,
          "States": [{}]
        }
      ]
    },
    {
      "Actions": [
        {
          "ActionID": "inner-uuid-2",
          "LinkedTitle": true,
          "Name": "Hotkey",
          "UUID": "com.elgato.streamdeck.system.hotkey",
          "Settings": {
            /* hotkey config */
          },
          "State": 0,
          "States": [{}]
        }
      ]
    }
  ]
}
```

### Multi-Action Structure

- `Actions` array at the top level contains step groups
- Each step group has an `Actions` array of actions to run together
- Steps execute sequentially; actions within a step run together

## Hotkey Settings Schema

```json
{
  "Coalesce": true,
  "Hotkeys": [
    {
      "KeyCmd": false,
      "KeyCtrl": true,
      "KeyShift": true,
      "KeyOption": false,
      "KeyModifiers": 6,
      "NativeCode": 83,
      "VKeyCode": 83,
      "QTKeyCode": 83
    }
  ]
}
```

### Hotkey Field Descriptions

| Field          | Type    | Description                 |
| -------------- | ------- | --------------------------- |
| `Coalesce`     | boolean | Prevent key repeat          |
| `KeyCmd`       | boolean | Windows/Command key pressed |
| `KeyCtrl`      | boolean | Control key pressed         |
| `KeyShift`     | boolean | Shift key pressed           |
| `KeyOption`    | boolean | Alt/Option key pressed      |
| `KeyModifiers` | integer | Bitmask of modifiers        |
| `NativeCode`   | integer | Platform-native key code    |
| `VKeyCode`     | integer | Windows virtual key code    |
| `QTKeyCode`    | integer | Qt framework key code       |

### KeyModifiers Bitmask

| Value | Modifiers      |
| ----- | -------------- |
| 0     | None           |
| 1     | Alt/Option     |
| 2     | Ctrl           |
| 3     | Ctrl+Alt       |
| 4     | Shift          |
| 5     | Shift+Alt      |
| 6     | Ctrl+Shift     |
| 7     | Ctrl+Shift+Alt |
| 8     | Win/Cmd        |
| 9     | Win/Cmd+Alt    |
| 10    | Win/Cmd+Ctrl   |

### Common Virtual Key Codes (VKeyCode)

| Key          | Code    | Key         | Code  |
| ------------ | ------- | ----------- | ----- |
| A-Z          | 65-90   | 0-9         | 48-57 |
| F1-F12       | 112-123 | Space       | 32    |
| Enter        | 13      | Escape      | 27    |
| Tab          | 9       | Backspace   | 8     |
| Delete       | 46      | Insert      | 45    |
| Home         | 36      | End         | 35    |
| Page Up      | 33      | Page Down   | 34    |
| Left         | 37      | Up          | 38    |
| Right        | 39      | Down        | 40    |
| Print Screen | 44      | Scroll Lock | 145   |
| Pause        | 19      | Num Lock    | 144   |

## Image Specifications

| Property   | Value                                    |
| ---------- | ---------------------------------------- |
| Format     | PNG (preferred), WEBP (animated)         |
| Dimensions | 288 × 288 pixels                         |
| Color      | RGB, 8-bit                               |
| Location   | `Profiles/{PageID}/Images/`              |
| Reference  | Relative path: `"Images/filename.png"`   |
| Naming     | Random alphanumeric (26 chars) or custom |

## Page ID Format

Page IDs (folder names under `Profiles/`) use a specific format:

- 26 uppercase alphanumeric characters
- Always ends with `Z`
- Example: `CPLDQL9IE50AW9CNOMCR0SOSOGZ`

When creating new pages, you can generate IDs or use any unique string.

## Complete Page Manifest Example

```json
{
  "Controllers": [
    {
      "Actions": {
        "0,0": {
          "ActionID": "44751278-f9a2-4138-99f8-e11dab46d521",
          "LinkedTitle": true,
          "Name": "Parent Folder",
          "Settings": {},
          "State": 0,
          "States": [{}],
          "UUID": "com.elgato.streamdeck.profile.backtoparent"
        },
        "1,0": {
          "ActionID": "a9faccf7-e739-45b9-a782-8c5b94fedbc0",
          "LinkedTitle": true,
          "Name": "Website",
          "Settings": {
            "openInBrowser": true,
            "path": "https://github.com"
          },
          "State": 0,
          "States": [
            {
              "Image": "Images/github-icon.png",
              "Title": "GitHub",
              "ShowTitle": true,
              "TitleAlignment": "bottom",
              "TitleColor": "#ffffff"
            }
          ],
          "UUID": "com.elgato.streamdeck.system.website"
        },
        "2,0": {
          "ActionID": "ad981afb-b7f1-46d9-8f89-374ff9827092",
          "LinkedTitle": true,
          "Name": "Hotkey",
          "Settings": {
            "Coalesce": true,
            "Hotkeys": [
              {
                "KeyCmd": false,
                "KeyCtrl": true,
                "KeyOption": false,
                "KeyShift": false,
                "KeyModifiers": 2,
                "NativeCode": 67,
                "QTKeyCode": 67,
                "VKeyCode": 67
              }
            ]
          },
          "State": 0,
          "States": [
            {
              "Title": "Copy",
              "FontSize": 12
            }
          ],
          "UUID": "com.elgato.streamdeck.system.hotkey"
        }
      },
      "Type": "Keypad"
    }
  ],
  "Icon": "",
  "Name": "My Page"
}
```
