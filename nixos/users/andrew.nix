{ pkgs, username, ... }@inputs:
{
	users.users.${username} = {
		isNormalUser = true;
		description = "Andrew Nguyen";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
	};
}
