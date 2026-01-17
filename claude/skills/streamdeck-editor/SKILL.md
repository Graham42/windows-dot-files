---
name: streamdeck-editor
description: Edit Elgato Stream Deck profiles by modifying JSON configuration files. Use when the user wants to add buttons, edit actions, modify profiles, or configure their Stream Deck programmatically. Triggers on mentions of "Stream Deck", or "streamdeck".
---

# Stream Deck Profile Editor

Edit Elgato Stream Deck profiles by directly modifying JSON configuration files.

## Quick Reference

**Profile Location (Windows):**

```
%APPDATA%\Elgato\StreamDeck\ProfilesV2\
```

**Structure:**

```
ProfilesV2/
└── {GUID}.sdProfile/
    ├── manifest.json          # Profile bundle metadata
    └── Profiles/
        └── {PageID}/
            ├── manifest.json  # Page with button actions
            └── Images/        # Button icons (288x288 PNG)
```

## Core Concepts

### 1. Profile Bundle vs Page

- **Profile Bundle** (`.sdProfile/manifest.json`): Container with device info, name, and list of pages
- **Page** (`Profiles/{PageID}/manifest.json`): Actual button layout with actions

### 2. Button Coordinates

Buttons are addressed as `"X,Y"` strings (0-indexed):

- X = column (left to right)
- Y = row (top to bottom)

**Stream Deck layouts:**

- Standard (15 keys): 5 columns × 3 rows → `"0,0"` to `"4,2"`
- XL (32 keys): 8 columns × 4 rows → `"0,0"` to `"7,3"`
- Mini (6 keys): 3 columns × 2 rows → `"0,0"` to `"2,1"`

### 3. Action Structure

Every button action follows this structure:

```json
{
  "ActionID": "unique-guid",
  "LinkedTitle": true,
  "Name": "Display Name",
  "UUID": "com.elgato.streamdeck.system.website",
  "Settings": {
    /* action-specific */
  },
  "State": 0,
  "States": [
    {
      "Title": "Button Label",
      "Image": "Images/filename.png",
      "ShowTitle": true,
      "TitleAlignment": "bottom",
      "TitleColor": "#ffffff",
      "FontSize": 9
    }
  ]
}
```

## Workflow for Editing Profiles

<!-- Feedback: As a first step, we probably want to make sure and confirm with the user that they are okay to go ahead with the edit. They should have a chance to back up the profile if they want, and then they should exit the Steam Deck software.  -->

### Step 1: Find the Profile

```bash
# List all profile bundles
ls "$APPDATA/Elgato/StreamDeck/ProfilesV2/"

# Read a profile bundle manifest to see its name
cat "$APPDATA/Elgato/StreamDeck/ProfilesV2/{GUID}.sdProfile/manifest.json"
```

### Step 2: Find the Page to Edit

The bundle manifest lists page UUIDs. Find the actual page:

```bash
# List pages in a profile
ls "$APPDATA/Elgato/StreamDeck/ProfilesV2/{GUID}.sdProfile/Profiles/"

# Read a page manifest to see its buttons
cat "$APPDATA/Elgato/StreamDeck/ProfilesV2/{GUID}.sdProfile/Profiles/{PageID}/manifest.json"
```

### Step 3: Edit the Page Manifest

Modify the `Controllers[0].Actions` object to add/edit/remove buttons.

### Step 4: Restart Stream Deck

<!-- FEEDBACK: Should we make sure that Stream Deck software is closed first before making any profile edits?  -->

Changes require restarting the Stream Deck software:

```bash
# Windows - restart Stream Deck
taskkill /IM "StreamDeck.exe" /F && start "" "C:\Program Files\Elgato\StreamDeck\StreamDeck.exe"
```

## Common Action Types

### Website Button

```json
{
  "ActionID": "generate-new-guid",
  "LinkedTitle": true,
  "Name": "Website",
  "UUID": "com.elgato.streamdeck.system.website",
  "Settings": {
    "openInBrowser": true,
    "path": "https://example.com"
  },
  "State": 0,
  "States": [{ "Title": "My Site" }]
}
```

### Open Application/File

```json
{
  "ActionID": "generate-new-guid",
  "LinkedTitle": true,
  "Name": "Open",
  "UUID": "com.elgato.streamdeck.system.open",
  "Settings": {
    "openInBrowser": true,
    "path": "\"C:\\Path\\To\\App.exe\""
  },
  "State": 0,
  "States": [{ "Title": "Launch App" }]
}
```

### Hotkey (Keyboard Shortcut)

```json
{
  "ActionID": "generate-new-guid",
  "LinkedTitle": true,
  "Name": "Hotkey",
  "UUID": "com.elgato.streamdeck.system.hotkey",
  "Settings": {
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
  },
  "State": 0,
  "States": [{ "Title": "Ctrl+Shift+S" }]
}
```

### Folder Navigation (Open Sub-Profile)

```json
{
  "ActionID": "generate-new-guid",
  "LinkedTitle": true,
  "Name": "Create Folder",
  "UUID": "com.elgato.streamdeck.profile.openchild",
  "Settings": {
    "ProfileUUID": "target-page-uuid"
  },
  "State": 0,
  "States": [{ "Title": "My Folder" }]
}
```

### Back to Parent

```json
{
  "ActionID": "generate-new-guid",
  "LinkedTitle": true,
  "Name": "Parent Folder",
  "UUID": "com.elgato.streamdeck.profile.backtoparent",
  "Settings": {},
  "State": 0,
  "States": [{}]
}
```

## Key Modifiers Reference

For hotkeys, use these modifier combinations:

| Modifier   | KeyCtrl | KeyShift | KeyCmd | KeyOption | KeyModifiers |
| ---------- | ------- | -------- | ------ | --------- | ------------ |
| None       | false   | false    | false  | false     | 0            |
| Ctrl       | true    | false    | false  | false     | 2            |
| Shift      | false   | true     | false  | false     | 4            |
| Ctrl+Shift | true    | true     | false  | false     | 6            |
| Win/Cmd    | false   | false    | true   | false     | 8            |
| Alt        | false   | false    | false  | true      | 1            |

**Common VKeyCodes:** A=65, S=83, C=67, V=86, Z=90, 0-9=48-57, F1-F12=112-123

## Generating UUIDs

ActionIDs should be unique GUIDs. Generate with:

```bash
# PowerShell
[guid]::NewGuid().ToString()

# Or use all zeros (Stream Deck doesn't validate)
"00000000-0000-0000-0000-000000000000"
```

## Adding Custom Button Images

1. Create a 288×288 PNG image
2. Save to `Profiles/{PageID}/Images/` with a unique filename
3. Reference in the action's State: `"Image": "Images/myicon.png"`

## Important Notes

- **Always backup** the profile directory before editing
- **JSON must be valid** - use a JSON validator before saving
- **Restart required** - Stream Deck must be restarted to see changes
- **File paths** in Settings need escaped backslashes: `"C:\\Path\\To\\File"`
- **Coordinates** are strings: `"0,0"` not `[0,0]`

## Detailed Schema Reference

For complete JSON schemas and all action types, see:

- [SCHEMA.md](SCHEMA.md) - Full JSON schema documentation
- [ACTIONS.md](ACTIONS.md) - All built-in and plugin action types

## Troubleshooting

**Changes not appearing?**

- Restart Stream Deck software
- Check JSON syntax is valid
- Verify file was saved to correct location

**Action not working?**

- Verify UUID is correct for the action type
- Check Settings object has required fields
- Ensure paths are properly escaped
