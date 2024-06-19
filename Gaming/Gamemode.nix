{ config, pkgs, ... }: {

	programs.gamemode = {
		# Whether to enable GameMode to optimise system performance on demand.
		# https://search.nixos.org/options?channel=24.05&show=programs.gamemode.enable
		enable = true;

		# Configuration for GameMode. Here, inhibits the screensaver.
		# https://search.nixos.org/options?channel=24.05&show=programs.gamemode.settings
		settings.general = { inhibit_screensaver = 0; };
	};

}
