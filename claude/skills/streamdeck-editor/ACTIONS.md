# Stream Deck Action Types Reference

Complete reference for all built-in and common plugin action types.

## Built-in System Actions

### Website

Opens a URL in the default browser.

**UUID:** `com.elgato.streamdeck.system.website`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Website",
  "UUID": "com.elgato.streamdeck.system.website",
  "Settings": {
    "openInBrowser": true,
    "path": "https://example.com"
  },
  "State": 0,
  "States": [{ "Title": "My Site", "Image": "Images/icon.png" }]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `openInBrowser` | boolean | Always `true` |
| `path` | string | URL to open |

---

### Open (Application/File)

Opens a file or application.

**UUID:** `com.elgato.streamdeck.system.open`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Open",
  "UUID": "com.elgato.streamdeck.system.open",
  "Settings": {
    "openInBrowser": true,
    "path": "\"C:\\Program Files\\App\\app.exe\""
  },
  "State": 0,
  "States": [{ "Title": "Launch App" }]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `openInBrowser` | boolean | Always `true` |
| `path` | string | File path with escaped quotes: `"\"C:\\path\""` |

**Note:** Paths must be wrapped in escaped quotes and use double backslashes.

---

### Hotkey (Keyboard Shortcut)

Sends a keyboard shortcut.

**UUID:** `com.elgato.streamdeck.system.hotkey`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Hotkey",
  "UUID": "com.elgato.streamdeck.system.hotkey",
  "Settings": {
    "Coalesce": true,
    "Hotkeys": [
      {
        "KeyCmd": false,
        "KeyCtrl": true,
        "KeyShift": false,
        "KeyOption": false,
        "KeyModifiers": 2,
        "NativeCode": 67,
        "VKeyCode": 67,
        "QTKeyCode": 67
      }
    ]
  },
  "State": 0,
  "States": [{ "Title": "Copy" }]
}
```

**Common Hotkey Examples:**

| Shortcut | KeyCtrl | KeyShift | KeyCmd | VKeyCode | KeyModifiers |
|----------|---------|----------|--------|----------|--------------|
| Ctrl+C | true | false | false | 67 | 2 |
| Ctrl+V | true | false | false | 86 | 2 |
| Ctrl+Z | true | false | false | 90 | 2 |
| Ctrl+S | true | false | false | 83 | 2 |
| Ctrl+Shift+S | true | true | false | 83 | 6 |
| Win+D | false | false | true | 68 | 8 |
| Alt+Tab | false | false | false | 9 | 1 |
| Alt+F4 | false | false | false | 115 | 1 |
| Print Screen | false | false | false | 44 | 0 |

---

### Multimedia

Controls media playback.

**UUID:** `com.elgato.streamdeck.system.multimedia`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Multimedia",
  "UUID": "com.elgato.streamdeck.system.multimedia",
  "Settings": {
    "actionIdx": 0
  },
  "State": 0,
  "States": [{}]
}
```

| actionIdx | Action |
|-----------|--------|
| 0 | Play/Pause |
| 1 | Stop |
| 2 | Previous Track |
| 3 | Next Track |
| 4 | Volume Up |
| 5 | Volume Down |
| 6 | Mute |

---

### Text

Types text (simulates keyboard input).

**UUID:** `com.elgato.streamdeck.system.text`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Text",
  "UUID": "com.elgato.streamdeck.system.text",
  "Settings": {
    "text": "Hello, World!",
    "sendEnter": false
  },
  "State": 0,
  "States": [{ "Title": "Type Text" }]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `text` | string | Text to type |
| `sendEnter` | boolean | Press Enter after text |

---

## Profile Navigation Actions

### Open Folder (Sub-Profile)

Navigates to a sub-profile/folder.

**UUID:** `com.elgato.streamdeck.profile.openchild`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Create Folder",
  "UUID": "com.elgato.streamdeck.profile.openchild",
  "Settings": {
    "ProfileUUID": "target-page-uuid-from-bundle-manifest"
  },
  "State": 0,
  "States": [{ "Title": "My Folder", "Image": "Images/folder.png" }]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `ProfileUUID` | string | UUID of target page (from bundle's `Pages.Pages` array) |

---

### Back to Parent

Returns to the parent profile/folder.

**UUID:** `com.elgato.streamdeck.profile.backtoparent`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Parent Folder",
  "UUID": "com.elgato.streamdeck.profile.backtoparent",
  "Settings": {},
  "State": 0,
  "States": [{}]
}
```

---

### Switch Profile

Switches to a different profile entirely.

**UUID:** `com.elgato.streamdeck.profile.rotate`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Switch Profile",
  "UUID": "com.elgato.streamdeck.profile.rotate",
  "Settings": {
    "ProfileUUID": "target-profile-bundle-uuid"
  },
  "State": 0,
  "States": [{ "Title": "Work Profile" }]
}
```

---

## Multi-Action

Executes multiple actions in sequence.

**UUID:** `com.elgato.streamdeck.multiactions.routine`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Multi Action",
  "UUID": "com.elgato.streamdeck.multiactions.routine",
  "Settings": {},
  "State": 0,
  "States": [{ "Title": "Do All", "Image": "Images/multi.png" }],
  "Actions": [
    {
      "Actions": [
        {
          "ActionID": "step1-uuid",
          "LinkedTitle": true,
          "Name": "Open",
          "UUID": "com.elgato.streamdeck.system.open",
          "Settings": { "openInBrowser": true, "path": "\"C:\\App1.exe\"" },
          "State": 0,
          "States": [{}]
        }
      ]
    },
    {
      "Actions": [
        {
          "ActionID": "step2-uuid",
          "LinkedTitle": true,
          "Name": "Website",
          "UUID": "com.elgato.streamdeck.system.website",
          "Settings": { "openInBrowser": true, "path": "https://example.com" },
          "State": 0,
          "States": [{}]
        }
      ]
    }
  ]
}
```

**Structure:** Each element in `Actions` is a step. Steps run sequentially. Multiple actions in a step run together.

---

## Soundboard Actions

### Play Audio

Plays a sound file.

**UUID:** `com.elgato.streamdeck.soundboard.playaudio`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Play Audio",
  "UUID": "com.elgato.streamdeck.soundboard.playaudio",
  "Settings": {
    "actionType": 1,
    "fadeLen": 1,
    "fadeType": 0,
    "outputType": "",
    "path": "C:\\Users\\user\\AppData\\Roaming\\Elgato\\StreamDeck\\Audio\\sound.mp3",
    "volume": 50
  },
  "State": 0,
  "States": [{ "Title": "Play Sound" }]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `path` | string | Full path to audio file |
| `volume` | integer | Volume 0-100 |
| `actionType` | integer | 0=Toggle, 1=Play, 2=Stop |
| `fadeLen` | integer | Fade duration in seconds |
| `fadeType` | integer | 0=None, 1=Fade In, 2=Fade Out |

---

## Common Plugin Actions

### OBS Studio - Scene Switch

**UUID:** `com.elgato.obsstudio.scene`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Scene",
  "UUID": "com.elgato.obsstudio.scene",
  "Settings": {
    "sceneName": "My Scene"
  },
  "State": 0,
  "States": [{ "Title": "Scene" }]
}
```

### OBS Studio - Source Toggle

**UUID:** `com.elgato.obsstudio.source`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Source",
  "UUID": "com.elgato.obsstudio.source",
  "Settings": {
    "sceneName": "Scene Name",
    "sourceName": "Source Name"
  },
  "State": 0,
  "States": [{}, {}]
}
```

### OBS Studio - Record

**UUID:** `com.elgato.obsstudio.record`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Record",
  "UUID": "com.elgato.obsstudio.record",
  "Settings": {},
  "State": 0,
  "States": [{}, {}]
}
```

### OBS Studio - Stream

**UUID:** `com.elgato.obsstudio.stream`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Stream",
  "UUID": "com.elgato.obsstudio.stream",
  "Settings": {},
  "State": 0,
  "States": [{}, {}]
}
```

---

### Elgato Control Center - Key Light

**UUID:** `com.elgato.controlcenter.toggle`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Toggle",
  "UUID": "com.elgato.controlcenter.toggle",
  "Settings": {
    "deviceID": "Elgato Key Light Air XXXX (MAC:ADDRESS)",
    "name": "Elgato Key Light Air XXXX",
    "type": 200
  },
  "State": 0,
  "States": [{}, {}]
}
```

### Elgato Control Center - Brightness

**UUID:** `com.elgato.controlcenter.brightness-slider`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Set Brightness",
  "UUID": "com.elgato.controlcenter.brightness-slider",
  "Settings": {
    "deviceID": "device-id",
    "lights": { "brightness": 50 },
    "name": "Key Light"
  },
  "State": 0,
  "States": [{}]
}
```

---

### Volume Controller - Output Device

**UUID:** `com.elgato.volume-controller.output-device-control`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Output Device Control",
  "UUID": "com.elgato.volume-controller.output-device-control",
  "Settings": {
    "action": "adjust",
    "deviceId": "default",
    "friendlyName": "",
    "style": "vertical",
    "volume": "50",
    "volumeStep": "-5"
  },
  "State": 0,
  "States": [{}]
}
```

| Setting | Type | Description |
|---------|------|-------------|
| `action` | string | `"adjust"`, `"set"`, `"mute"`, `"unmute"`, `"toggle"` |
| `deviceId` | string | `"default"` or specific device ID |
| `volume` | string | Target volume (for `"set"`) |
| `volumeStep` | string | Step amount (positive or negative) |

---

### Spotify - Play URI

**UUID:** `com.barraider.spotifyplayuri`

```json
{
  "ActionID": "uuid",
  "LinkedTitle": true,
  "Name": "Play URI",
  "UUID": "com.barraider.spotifyplayuri",
  "Settings": {
    "devices": [
      { "id": "device-id", "name": "Device Name" }
    ],
    "devicesSelected": "device-id",
    "playType": 0,
    "playURI": "spotify:playlist:PLAYLIST_ID",
    "tokenExists": true,
    "version": "2.9"
  },
  "State": 0,
  "States": [{ "Title": "Play", "Image": "Images/spotify.png" }]
}
```

---

## Action UUID Quick Reference

| Action | UUID |
|--------|------|
| Website | `com.elgato.streamdeck.system.website` |
| Open | `com.elgato.streamdeck.system.open` |
| Hotkey | `com.elgato.streamdeck.system.hotkey` |
| Text | `com.elgato.streamdeck.system.text` |
| Multimedia | `com.elgato.streamdeck.system.multimedia` |
| Multi-Action | `com.elgato.streamdeck.multiactions.routine` |
| Open Folder | `com.elgato.streamdeck.profile.openchild` |
| Back to Parent | `com.elgato.streamdeck.profile.backtoparent` |
| Switch Profile | `com.elgato.streamdeck.profile.rotate` |
| Play Audio | `com.elgato.streamdeck.soundboard.playaudio` |
| OBS Scene | `com.elgato.obsstudio.scene` |
| OBS Source | `com.elgato.obsstudio.source` |
| OBS Record | `com.elgato.obsstudio.record` |
| OBS Stream | `com.elgato.obsstudio.stream` |
| Control Center Toggle | `com.elgato.controlcenter.toggle` |
| Volume Control | `com.elgato.volume-controller.output-device-control` |
| Spotify Play | `com.barraider.spotifyplayuri` |

---

## Creating Custom Actions

To add a button with any action:

1. Copy the appropriate template above
2. Generate a new `ActionID` (UUID or all zeros)
3. Fill in the `Settings` with your values
4. Customize `States` for appearance
5. Add to the page manifest under the desired coordinate

```json
{
  "Controllers": [
    {
      "Actions": {
        "0,0": { /* paste your action here */ }
      },
      "Type": "Keypad"
    }
  ]
}
```
