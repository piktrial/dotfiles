{ pkgs, ... }: {
	home.packages = with pkgs; [
		# for appimage wrappers
    		appimage-run

    		# user domain
    		neovim			# like your ass doesn't know what neovim is
    		fastfetch 		# flexing on the haters
		pfetch			# flex harder
    		ranger 			# TUI file manager
    		yazi 			# also, a TUI file manager, prefer ranger but this has image/media support
		pavucontrol
    		conky
    		home-manager
    		dzen2
    		rofi 			# application launcher
    		vesktop
    		mpv
    		flameshot
    		feh 			# image viewer and wallpaper setter
		sxiv			# image viewer 2
		beets			# music library manager
		wallust			# desktop theming

    		# archives
    		zip
    		xz
    		unzip
    		p7zip

    		# utils
    		jq   			# json processor
    		eza  			# modern `ls`
		zoxide			# modern `cd`
    		walk 			# "walk" down directories
		ripgrep			# ive been told its search on crack
    		fzf 			# cli fuzzy finder
    		imagemagick 		# image manipulation
		xclip			# cli clipboard lib/tool
		xdotool			# i forget
		playerctl		# media control
		ffmpegthumbnailer	# video thumbnailer

    		# networking tools
    		mtr      		# network diag
    		dnsutils 		# `dig` and `nslookup`
    		ldns     		# `dig` replacement
    		aria2    		# everything download utility
    		yt-dlp   		# multimedia download tool
    		nmap     		# network discov and security auditing

    		# misc
    		file
    		which
    		tree
    		gawk
    		zstd

    		# nix-related
    		# `nom` works just like `nix` but has better logs
    		nix-output-monitor

    		# productivity
    		hugo 			# static site generator
    		glow 			# markdown preview in terminal

    		# sys monitors
    		btop  			# `htop` replacement
    		iotop 			# io monitoring
    		iftop 			# network monitoring

    		# sys call monitors
    		lsof			# open file tracing
    		strace			# system trace
    		ltrace			# lib trace

    		# system tools
    		lm_sensors
    		ethtool
    		pciutils 		# lspci
    		usbutils		# lsusb
	];
}
