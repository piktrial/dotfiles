{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		ntfs3g
		zsh
		git
		wget
	];
}

