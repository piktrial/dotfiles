{ config, pkgs, ... }: {
	programs.ghostty = {
		enable = true;
		package = pkgs.ghostty;
	};

	home.file.".config/ghostty/config".text = ''
		# theme = rose-pine
		theme = Square
		window-decoration = false
    		background-opacity = 0.76
    		background-blur-radius = 60
    		font-size = 10
	'';
}
