{ lib, pkgs, ... }: { programs = rec {
	# Nintendo DS(i) emulator.
	desmume.install = true;

	# CLI program for managing Minecraft mods and modpacks from various sources.
	ferium.install = true;

	# Native GOG, Epic, and Amaon Games launcher.
	heroic.install = false;

	# Modern GBA emulator with a focus on accuracy.
	mgba.install = true;

	# PlayStation 2 emulator.
	pcsx2.install = true;

	# Full-featured Minecraft launcher.
	prismlauncher.install = true;

	# PlayStation 3 emulator.
	rpcs3.enable = true;

	# XBOX emulator.
	xemu.install = true;

	vintagestory = {
		# Whether to install Vintage Story, and indie sandbox game about innovation and exploration.
		enable = true;

		# Whether to open ports in the firewall for local game discovery and UDNPD device discovery.
		openFirewall = true;
	};

	gamemode = {
		# Whether to enale GameMode to optimize system performances on demand when gaming.
		enable = true;

		# Disable any screen saver when using gamemode.
		settings.general.inhibit_screensaver = 0;
	};

	gamescope = {
		# Whether to enable the Gamescope compositor and session.
		enable = true;

		# Whether to add `cap_sys_nice` capablilities to GameScope, so that it may renice itself.
		capSysNice = true;
	};

	steam = {
		# Whether to perpetuate the cycle of the PC gamer.
		enable = true;

		# Whether to enable loading the extest library into Steam.
		# This is to translate X11 input events to uinput events,
		# e.g. for using Steam Input on Wayland.
		extest.enable = true;

		# Extra packages to be used as compatibility tools for Steam on Linux.
		extraCompatPackages = [ pkgs.proton-ge-bin ];

		# Additional packages to add to the Steam environment.
		extraPackages = lib.optional gamescope.enable pkgs.gamescope
		++ lib.optional gamemode.enable pkgs.gamemode;

		# Whether to enale the GameScope session for Steam.
		gamescopeSession.enable = lib.mkIf gamescope.enable true;

		# Whether to open ports in the firewall for Steam Remote Play.
		remotePlay.openFirewall = true;
	};
}; }