{ inputs, config, pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
		./modules/boot.nix
		./modules/networking.nix
		./modules/locale.nix
		./modules/audio.nix
		./modules/desktop.nix
		./modules/system-users.nix
		./modules/packages.nix
		./modules/extras.nix
	];

	# never EVER change this
	# essentially, this is the version that you init'd nixOS on, even if you update
	# - everything will be fine.
	system.stateVersion = "24.11";
}
