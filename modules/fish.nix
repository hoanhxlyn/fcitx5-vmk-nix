{pkgs, ...}: 
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			''
			;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch --flake ~/dotconfigs";
			cleanup = "sudo nix-collect-garbage -d";
			update = "sudo nix flake update --flake ~/dotconfigs";
			ls = "eza --long --no-user";
			cd = "z";
		};
		plugins = [
			{name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src;}
			{name = "done"; src = pkgs.fishPlugins.done.src;}
			{name = "git"; src = pkgs.fishPlugins.plugin-git.src;}
		];
	};
}
