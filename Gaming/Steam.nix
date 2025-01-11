{ config, pkgs, ... }: { programs.steam = {

	# Whether to enable Steam.
	enable = true;

	# Whether to enable loading the extest library into Steam, to translate X11 input events to uinput events.
	# (e.g. for using Steam Input on Wayland).
	extest.enable = true;

	# Extra packages to be used as compatibility tools for Steam on Linux.
	extraCompatPackages = [ pkgs.unstable.proton-ge-bin ];

	# Additional packages to add to the Steam environment.
	extraPackages = [
		# SteamOS session compositing window manager.
		pkgs.unstable.gamescope

		# Optimise Linux system performance for gaming on demand.
		pkgs.gamemode
	];

	# Whether to open ports in the firewall for Steam Retome Play.
	remotePlay.openFirewall = true;

}; }
