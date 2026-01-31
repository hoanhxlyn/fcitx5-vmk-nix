{ pkgs, ... }@inputs:
{
	programs.neovim = {
		enable = true;
		vimAlias = true;
		defaultEditor = true;
	};
}
