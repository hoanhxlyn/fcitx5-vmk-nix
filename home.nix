{config, pkgs, username, stateVersion, ...}:
{
	imports = [
		./modules/bundle.nix
	];
	home = {
		inherit username stateVersion;
		homeDirectory = "/home/${username}";
	};
	gtk = {
		enable = true;
		font = {
			name = "JetBrainsMono Nerd Font";
			size = 12;
		}
	}
}
