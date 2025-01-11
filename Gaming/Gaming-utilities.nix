{ config, pkgs, ... }: { programs = {

	gamemode = {
		# Whether to enable GameMode to optimise system performance on demand for gaming.
		enable = true;

		# System-wide configuration for GameMode (/etc/gamemode.ini).
		settings.general = { inhibit_screensaver = 0; };
	};

	gamescope = {
		# Whether to enbale gamescope, the SteamOS session compositing window manager.
		enable = true;

		# The gamescope package to use.
		package = pkgs.unstable.gamescope;
	};

}; }
