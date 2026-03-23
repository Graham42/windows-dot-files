#!/usr/bin/env pwsh
# =============================================================================
# psmux-theme-1g - Custom theme for psmux
# =============================================================================
#
# Colors based on 1g of Code branding: warm workshop workbench aesthetic.
# Layout based on psmux-theme-everforest.
#
# https://github.com/Graham42/1g-of-code-website/blob/main/docs/branding.md
# =============================================================================

function Get-PsmuxBin {
    foreach ($n in @('psmux','pmux','tmux')) {
        $b = Get-Command $n -ErrorAction SilentlyContinue
        if ($b) { return $b.Source }
    }
    return 'psmux'
}

$PSMUX = Get-PsmuxBin

# --- Palette ---
# Backgrounds (warm dark neutrals)
$bg0 = '#0f0f0f'   # main status bar bg
$bg1 = '#1a1812'   # surface / separator bg
$bg2 = '#242018'   # elevated surface (derived)
$bg3 = '#2e2a22'   # borders / most elevated
# Foreground
$fg    = '#f5f0e8' # warm off-white text
$gray  = '#9a9080' # dimmed text
$gray2 = '#b5aa98' # slightly brighter dimmed (derived)
# Accents
$amber  = '#f0a500' # brand accent - primary highlight
$amberD = '#c88800' # darker amber (for use as bg with dark fg)
$red    = '#c94a3a' # warm alert red
$orange = '#e07030' # warm activity orange

# --- Separators ---
$sLR  = [char]0xe0b0  # left-to-right filled arrow (status bar)
$sRL  = [char]0xe0b2  # right-to-left filled arrow (status bar)
$tabL  = [char]0xe0bc  # filled forward slash, left cap (active tab)
$tabR  = [char]0xe0bc  # filled forward slash, right cap (active tab)
$tabLT = [char]0xe0bc  # filled forward slash, left cap (inactive tab)
$tabRT = [char]0xe0bc  # filled forward slash, right cap (inactive tab)

# --- Icons ---
$iSess   = [char]0xf0571  # session icon
$iWin    = [char]0xf0317  # window icon
$iClock  = [char]0xf0150  # clock
$iCal    = [char]0xf073   # calendar
$iUser   = [char]0xf007   # user

# --- Status indicators ---
$zoomInd  = "#{?window_zoomed_flag,#[fg=${amber}]  ,}"
$paneCount = "#{?#{e|>:#{window_panes}#,1},#[fg=${gray}]  #{window_panes},}"
$pfx      = "#{?client_prefix,#[fg=${red}]#[bg=${bg0}]${sRL}#[bg=${red}]#[fg=${bg0},bold] PREF #[bg=${bg0}],}"

# --- Apply settings ---
& $PSMUX set -g status on                                         | Out-Null
& $PSMUX set -g status-position bottom                            | Out-Null
& $PSMUX set -g status-justify left                               | Out-Null
& $PSMUX set -g status-interval 5                                 | Out-Null
& $PSMUX set -g status-style "bg=${bg0},fg=${fg}"                 | Out-Null
& $PSMUX set -g window-status-separator ""                        | Out-Null

# Left: session badge
$left  = "#[bg=${bg0},fg=${amber}] 🪟  "
$left += "#[bg=${amber},fg=${bg0},bold]${iSess} #S "
$left += "#[fg=${gray2},bg=${bg1}] ${iUser} #{user} "
$left += "#[fg=${bg1},bg=${bg0}]${sLR} "
& $PSMUX set -g status-left $left          | Out-Null
& $PSMUX set -g status-left-length 45      | Out-Null

# Right: prefix indicator, clock, date
$right  = "${pfx}"
$right += "#[fg=${bg2},bg=${bg0}]${sRL}#[fg=${amber},bg=${bg2}] ${iClock} %H:%M "
$right += "#[fg=${bg3},bg=${bg2}]${sRL}#[fg=${fg},bg=${bg3}] ${iCal} %a "
$right += "#[fg=${amber},bg=${bg3}]${sRL}#[fg=${bg0},bg=${amber},bold] ${iCal} %d-%b "
& $PSMUX set -g status-right $right        | Out-Null
& $PSMUX set -g status-right-length 80     | Out-Null

# Window tabs
& $PSMUX set -g window-status-format `
    "#[fg=${bg0},bg=${bg1}]${tabLT}#[fg=${gray},bg=${bg1}]${iWin} #I #W ${paneCount}#[fg=${bg1},bg=${bg0}]${tabRT}" `
    | Out-Null
& $PSMUX set -g window-status-current-format `
    "#[fg=${bg0},bg=${amber}]${tabL}#[fg=${bg0},bg=${amber},bold]${iWin} #I #W ${zoomInd}${paneCount}#[fg=${amber},bg=${bg0}]${tabR}" `
    | Out-Null

& $PSMUX set -g window-status-last-style       "underscore"                      | Out-Null
& $PSMUX set -g window-status-activity-style   "fg=${orange},bg=${bg0},bold"     | Out-Null
& $PSMUX set -g window-status-bell-style       "fg=${red},bg=${bg0},bold"        | Out-Null
& $PSMUX set -g pane-active-border-style       "fg=${amber}"                     | Out-Null
& $PSMUX set -g pane-border-style              "fg=${bg3}"                       | Out-Null
& $PSMUX set -g pane-border-indicators         "arrows"                          | Out-Null
& $PSMUX set -g message-style                  "bg=${bg1},fg=${fg}"              | Out-Null
& $PSMUX set -g message-command-style          "bg=${bg1},fg=${fg}"              | Out-Null
& $PSMUX set -g mode-style                     "bg=${amber},fg=${bg0}"           | Out-Null

Write-Host "psmux-theme-1g: loaded" -ForegroundColor DarkGray
