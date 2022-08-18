import XMonad

import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn (manageSpawn, spawnOn)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Dwindle
import XMonad.Layout.Gaps
import XMonad.Layout.Reflect
import XMonad.Layout.Spiral
import XMonad.Layout.WindowNavigation
import XMonad.ManageHook
import XMonad.Util.EZConfig
import XMonad.Util.Loggers

import XMonad.Hooks.ManageDocks (AvoidStruts, ToggleStruts (..), avoidStruts, docks, docksEventHook, manageDocks)
import XMonad.Layout.Maximize (Maximize, maximize, maximizeRestore)
import qualified XMonad.Layout.Spacing as Spacing

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ withEasySB (statusBarProp "xmobar ~/.xmonad/xmobar" (pure myXmobarPP)) defToggleStrutsKey myConfig

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = orange " • "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = orange . wrap " " "" . xmobarBorder "Top" "#FE8019" 2
    , ppHidden = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent = red . wrap (yellow "!") (yellow "!")
    , ppOrder = \[ws, l, _, wins] -> [ws, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
 where
  formatFocused = wrap (white "[") (white "]") . orange . ppWindow
  formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . white . ppWindow

  ppWindow :: String -> String
  ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

  blue, lowWhite, magenta, red, white, yellow :: String -> String
  magenta = xmobarColor "#ff79c6" ""
  blue = xmobarColor "#bd93f9" ""
  white = xmobarColor "#FFB74D" ""
  yellow = xmobarColor "#f1fa8c" ""
  red = xmobarColor "#ff5556" ""
  lowWhite = xmobarColor "#FFCC80" ""
  orange = xmobarColor "#FE8019" ""
  lightOrange = xmobarColor "#FFB74D" ""

myConfig =
  def
    { modMask = mod4Mask -- Rebind Mod to the Super key
    , layoutHook = Spacing.spacingWithEdge 10 $ myLayout
    , manageHook = myManageHook
    , focusedBorderColor = "#FE8019"
    , normalBorderColor = "#141C21"
    , borderWidth = 4
    , workspaces = ["term", "web", "vars", "coms", "mail", "music"]
    , focusFollowsMouse = False
    -- , startupHook = customStartHook
    }
    `additionalKeysP` [ ("M-<Return>", spawn "kitty")
                      , ("M-<Space>", spawn "dmenu_run -nb \"#141C21\" -nf \"#FB8C00\" -sb \"#FB8C00\" -sf \"#141C21\" -fn scientifica -y 6 -x 800 -z 800")
                      , ("M-S-n", spawn "chromium --profile-directory=Default")
                      , ("M-S-w", kill)
                      , ("M1-<Tab>", spawn "rofi -show window")
                      , ("M-m", sendMessage NextLayout)
                      , ("M-[", prevWS)
                      , ("M-]", nextWS)
                      , ("M-q", spawn "xmonad --recompile; xmonad --restart")
                      , ("M-h", sendMessage $ Go R)
                      , ("M-l", sendMessage $ Go L)
                      , ("M-j", sendMessage $ Go U)
                      , ("M-k", sendMessage $ Go D)
                      , ("M-v", spawn $ "sleep 0.25 && xdotool type --clearmodifiers \"$(xclip -o -selection primary)\"")
                      , ("<XF86AudioLowerVolume>", spawn $ "ponymix decrease 1")
                      , ("<XF86AudioRaiseVolume>", spawn $ "ponymix increase 1")
                      , ("M-i", spawn $ "ponymix increase 1")
                      , ("M-<Backspace>", spawn $ "betterlockscreen -l blur")
                      , ("M-o", spawn $ "scrot --exec 'mv $f ~/Pictures/Screenshots'")
                      ]

myLayout = modify (reflectHoriz $ reflectVert $ gaps [(D, 1)] $ windowNavigation emptyBSP ||| Full)
 where
  modify = avoidStruts . maximize . Spacing.smartSpacing 0
  tall = Tall 1 (3 / 100) (1 / 2)

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog --> doFloat
    ]

customStartHook = do
  -- spawnOn "1" "kitty"
  -- spawnOn "2" "chromium"
  -- spawnOn "4" "slack"
  -- spawnOn "4" "teams"
  spawnOn "5" "mailspring"
