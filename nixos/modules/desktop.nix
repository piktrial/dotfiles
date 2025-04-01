{ config, pkgs, ... }:

{
	# Enable the X11 windowing system
	services.xserver.enable = true;

	# Display Manager
	# services.xserver.displayManager.lightdm.enable = true;
        services.displayManager.ly.enable = true;

	# Desktop Environment
	services.xserver.desktopManager.budgie.enable = true;

	# Window Manager: XMonad
	services.xserver.windowManager.xmonad = {
		enable = true;
		enableContribAndExtras = true;
		config = builtins.readFile ../../xmonad.hs;
	};

	# Keyboard layout
	services.xserver.xkb = {
		layout = "au";
		variant = "";
	};

	# Touchpad support (optional, disable if using external mouse only)
	# services.xserver.libinput.enable = true;
}

