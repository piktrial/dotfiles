{ config, pkgs, ... }:

{
	services.picom = {
		enable = true;
		backend = "glx";
		fade = true;
		settings = {
			blur = {
				method = "dual_kawase";
				strength = 5.0;
		   	 	background = true;
		   	 	background-frame = true;
		   	 	background-fixed = true;
		   	 	deviation = 1.0;
		   	 	size = 10;
			};

			active-opacity = 1.0;
			inactive-opacity = 0.95;
			opacity-rule = [
				"90:class_g = 'Ghostty'"
			];
		};
	};
}
