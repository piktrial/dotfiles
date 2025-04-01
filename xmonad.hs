import XMonad
import XMonad.ManageHook
import XMonad.Util.EZConfig
import XMonad.Actions.SpawnOn
-- layout imports
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Spacing 
-- i dunno yet
import XMonad.Util.SpawnOnce -- for startup hook
import XMonad.Util.Ungrab    -- remove in 0.18 xmonad (deprecated)
import XMonad.Util.Run (spawnPipe)
-- hooks
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
-- part from config steal
import System.Exit
import System.IO (hPutStrLn, Handle)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Ratio
-- possibly redundant
import XMonad.Util.EZConfig (additionalKeysP)

-- preferences
myModMask = mod4Mask
myTerminal = "ghostty"

-- ricing
myBorderWidth = 2
myNormalBorderColor = "#2E0F15"
myFocusedBorderColor = "#70163C"

-- on startup
myStartupHook = do
	spawnOnce "xclip"
	spawnOn "2:discord" "vesktop"
	spawnOn "5:steam" "flatpak run com.valvesoftware.Steam"
	spawnOnce "feh --bg-fill /home/melanie/.nix/wallpapers/1main.jpg"

myManageHook = composeAll
	[ className =? "vesktop" 		--> doShift "2:discord"
	, className =? "steam"   		--> doShift "5:steam"
	, className =? "steam_app_" 		--> doFloat
								-- x, y, w, h
	, title	    =? "Friends List" 		--> doRectFloat (W.RationalRect (3 % 4) (1 % 4) (1 % 4) (5 % 8)) 
	]

-- layout
myLayoutHook =
	onWorkspace "5:steam" Full $
	-- onWorkspace "3:music" (Mirror tiled) $
		avoidStruts $ spacingWithEdge 7 (tiled ||| Full)
	where
		-- threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
		tiled    = Tall nmaster delta ratio
		nmaster  = 1      -- default number of windows in the master pane
		ratio    = 1/2    -- default proportion of screen occupied by master pane
		delta    = 3/100  -- percent of screen to increment by when resizing panes

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:main", "2:discord", "3:music", "4:util", "5:steam"]

myDzen2Command = "dzen2 -dock -x '0' -y '0' -h '24' -w '1719' -ta 'l' -fg '#ffffff' -bg '#000000'"
myClockCommand = "while true; do date '+%a %b %d %H:%M:%S'; sleep 1; done | dzen2 -dock -x 1720 -w 200 -y 0 -h 24 -ta r -fg '#ffffff' -bg '#000000'"
myPP = def -- pretty printer
	{ ppCurrent = dzenColor "#ebac54" "" . wrap "[" "]"  -- current workspace in orange
	, ppVisible = dzenColor "#ffffff" ""                 -- visible but not current workspace
	, ppHidden  = dzenColor "#cccccc" ""                 -- hidden workspaces
	, ppLayout  = dzenColor "#ffcc00" ""                 -- layout name in yellow
	, ppTitle   = dzenColor "#ffffff" "" . shorten 80    -- title of active window
	, ppSep     = " | "                                  -- separator
	}

-- keybinds
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
-- launch
	-- bound terminal
	[ ((modm,		xK_Return), spawn $ XMonad.terminal conf) 
	-- rofi (application launcher)
	, ((modm .|. shiftMask, xK_d ), spawn "rofi -show drun")
	-- btop (system monitor)
	, ((modm .|. shiftMask, xK_p ), spawn "ghostty -e btop")
	, ((modm .|. shiftMask, xK_s ), spawn "flameshot gui")
-- management
	-- close focused window
	, ((modm .|. shiftMask, xK_w ), kill)
	 -- Rotate through the available layout algorithms
	, ((modm,		xK_space ), sendMessage NextLayout)
	--  Reset the layouts on the current workspace to default
	, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
	-- Resize viewed windows to the correct size 
	, ((modm,		xK_n ), refresh) -- REBIND
	-- Move focus to the next window
	, ((modm,		xK_Tab), windows W.focusDown)
	-- Move focus to the previous window
	, ((modm,		xK_h ), windows W.focusUp  )
	-- Move focus to the next window
	, ((modm,		xK_l), windows W.focusDown)
	-- Move focus to the master window
	, ((modm,		xK_m ), windows W.focusMaster  ) -- REBIND
	-- Swap the focused window and the master window
	, ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- REBIND
	-- Swap the focused window with the next window
	, ((modm .|. shiftMask, xK_k ), windows W.swapDown  )
	-- Swap the focused window with the previous window
	, ((modm .|. shiftMask, xK_j ), windows W.swapUp)
	-- Shrink the master area
	, ((modm .|. shiftMask, xK_h ), sendMessage Shrink)
	-- Expand the master area
	, ((modm .|. shiftMask, xK_l ), sendMessage Expand)
	-- Push window back into tiling
	, ((modm,		xK_t ), withFocused $ windows . W.sink)
	-- Increment the number of windows in the master area
	, ((modm  , xK_comma ), sendMessage (IncMasterN 1))
	-- Deincrement the number of windows in the master area
	, ((modm  , xK_period), sendMessage (IncMasterN (-1)))
	-- Toggle the status bar gap
	-- Use this binding with avoidStruts from Hooks.ManageDocks.
	-- See also the statusBar function from Hooks.DynamicLog.
	--
	-- Quit xmonad
	, ((modm .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
	-- Restart xmonad
	, ((modm, 		xK_q ), spawn "xmonad --recompile; xmonad --restart")
	, ((modm .|. shiftMask, xK_BackSpace), spawn "pkill dzen2")
	]
-- weird workspace keybind function i stole from default config
	++
	-- mod-[1..9], switch to workspace N
	-- mod-shift-[1..9], move client to workspace N
	[((m .|. modm, k), windows $ f i)
		| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
		, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- all my custom content
myConfig dzenProc = def
	{
	terminal		= myTerminal,
	modMask			= myModMask,
	keys			= myKeys,
	workspaces		= myWorkspaces,

	borderWidth		= myBorderWidth,
	normalBorderColor	= myNormalBorderColor,
	focusedBorderColor	= myFocusedBorderColor,

	-- hooks
	startupHook		= myStartupHook,
	layoutHook		= myLayoutHook,
	manageHook		= manageDocks <+> myManageHook <+> manageHook def,
	logHook			= dynamicLogWithPP myPP { ppOutput = hPutStrLn dzenProc }
	}

main :: IO ()
-- union with default xmonad
main = do
	workspaces <- spawnPipe myDzen2Command
	spawn myClockCommand
	xmonad $ ewmh $ docks (myConfig workspaces)
