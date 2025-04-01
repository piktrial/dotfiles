{ ... }:

{
	# flatpak support
	services.flatpak.enable = true;

	# CUPS printing support
	services.printing.enable = true;

	# firefox global
	programs.firefox.enable = true;

	# Optional: uncomment if you want openssh or firewall rules later
	# services.openssh.enable = true;
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# networking.firewall.enable = false;
}

