{ ... }: {
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		initExtra = ''
		  eval "$(zoxide init zsh)"
		'';

		oh-my-zsh = {
			enable = true;
			theme = "mgutz";
			plugins = [ "git" "z" "sudo" ];
		};

		shellAliases = {
			ff = "fastfetch";
			v = "nvim";
			navi = "yazi";
			ls = "eza -h --group-directories-first --icons";
			switch	= "sudo nixos-rebuild switch --flake /home/melanie/.nix#macaron";
			test	= "sudo nixos-rebuild test --flake /home/melanie/.nix#macaron";
			refresh = "sudo nixos-rebuild test --flake /home/melanie/.nix#macaron && xmonad --restart";
		};
	};
}
