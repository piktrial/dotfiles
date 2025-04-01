{ config, pkgs, inputs, lib, ... }: {
	imports = [
		# apps
		./modules/apps/ghostty.nix	# ghostty config
		./modules/apps/dunst.nix
		# regular modules
		./modules/appearance.nix	# ricing (picom)
		./modules/apps.nix		# installing packages 
		./modules/session-vars.nix	# env
		./modules/wrappers.nix		# appimage desktop entry machine
		./modules/zsh.nix		# everything zsh related
	];


	home = {
		username = "melanie";
		homeDirectory = "/home/melanie";
		stateVersion = "25.05";
	};

	fonts.fontconfig.enable = true;
}
