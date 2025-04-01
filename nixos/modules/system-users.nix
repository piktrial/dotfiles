{ config, pkgs, ... }:

{
	users.users.melanie = {
		isNormalUser = true;
		description = "sunny";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
			# You can add user-specific system packages here if needed
			# thunderbird
		];
	};

	programs.zsh.enable = true;
}

