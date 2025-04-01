{ ... }: {
	services.dunst = {
		enable = true;

		settings = {
			global = {
				frame_color = "#44475a";
				separator_color = "frame";
				font = "Monospace 10";
				timeout = 5;
			};

			urgency_low = {
				background = "#282a36";
				foreground = "#f8f8f2";
			};

			urgency_normal = {
				background = "#282a36";
				foreground = "#f8f8f2";
			};

			urgency_critical = {
				background = "#ff5555";
				foreground = "#ffffff";
				frame_color = "#ff5555";
			};
		};
	};
}

