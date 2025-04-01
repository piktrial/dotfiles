{
	description = "nixos flake beginners edition";

	inputs = {
		# nixpkgs
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# home-manager
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# nixvim
		nixvim.url = "github:elythh/nixvim";
	};

	outputs = inputs@{ self, nixvim, nixpkgs, home-manager, ... }:
		{
			nixosConfigurations = {
				macaron = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						./nixos/configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.melanie = import ./home/melanie.nix;
							home-manager.extraSpecialArgs = {
							  inherit inputs;
							};
						}
					];
				};
			};
		};
}

