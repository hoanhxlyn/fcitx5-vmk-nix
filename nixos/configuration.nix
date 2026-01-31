{ config, pkgs, hostName, username, stateVersion, ... }:
{
	imports = [
		./hardware-configuration.nix
		./programs.nix
		./i18n.nix
		./users/andrew.nix
		./fonts.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = hostName;
#networking.wireless.enable = true;
	networking.networkmanager.enable = true;
	time.timeZone = "Asia/Ho_Chi_Minh";
	hardware.pulseaudio.enable = false;
	services = {
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		xserver = {
			enable = true;
			autoRepeatDelay = 200;
			autoRepeatInterval = 35;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
		printing.enable = false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
		power-profiles-daemon.enable = false;
		tlp = {
			enable = true;
			settings = {
				CPU_SCALING_GOVERNOR_ON_AC = "performance";
				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
				CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
				CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
				STOP_CHARGE_THRESH_BAT0 = 80;
# START_CHARGE_THRESH_BAT0 = 75;
			};
		};
	};

	security.rtkit.enable = true;
	environment.systemPackages = with pkgs; [ 
		vim
		wget
		git
		alacritty
	];
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

	system.stateVersion = stateVersion;

}
