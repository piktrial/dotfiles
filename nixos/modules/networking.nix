{ ... }:

{
	networking = {
		hostName = "macaron";
		networkmanager.enable = true;

		extraHosts = ''
			192.168.0.242 kitchen
		'';
	};

	# Optional extras, uncomment if you use them:
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}

