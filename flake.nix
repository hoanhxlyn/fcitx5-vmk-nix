{
	description = "Andrewix - flake it till we hit it";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		homeManager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		neovimNightly.url = "github:nix-community/neovim-nightly-overlay";
	};
	outputs = { self, nixpkgs, homeManager, ... }@inputs:
		let 
		system = "x86_64-linux";
	username = "andrew";
	hostName = "andrewix";
	stateVersion = "25.11";
	in {
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
				inherit inputs username hostName stateVersion;
			};
			modules = [ 
			./nixos/configuration.nix
			{
				nixpkgs.overlays = [
					inputs.neovimNightly.overlays.default
				];
			}
			homeManager.nixosModules.home-manager {
				home-manager = {
					extraSpecialArgs = {
						inherit inputs username hostName stateVersion;
					};
					useGlobalPkgs = true;
					useUserPackages = true;
					users.${username} = import ./home.nix;
					backupFileExtension = "backup";
				};
			}
			];
		};
	};
}
