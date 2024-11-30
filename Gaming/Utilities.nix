# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=programs.gamemode.enable
# • https://search.nixos.org/options?channel=24.11&show=programs.gamemode.settings
# • https://search.nixos.org/options?channel=24.11&show=programs.gamescope.enable
# • https://search.nixos.org/options?channel=24.11&show=programs.gamescope.package

{ config, pkgs, ... }: { programs = {

	gamemode = {
		# Whether to enable GameMode to optimise system performance on demand.
		enable = true;

		# System-wide configuration for GameMode (/etc/gamemode.ini).
		settings.general = { inhibit_screensaver = 0; };
	};

	gamescope = {
		# Whether to enable gamescope, the SteamOS session compositing window manager.
		enable = true;

		# The gamescope package to use.
		package = pkgs.unstable.gamescope;
	};

}; }
