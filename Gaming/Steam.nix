# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Steam
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=programs.steam.enable
# • https://search.nixos.org/options?channel=24.11&show=programs.steam.extest.enable
# • https://search.nixos.org/options?channel=24.11&show=programs.steam.extraPackages
# • https://search.nixos.org/options?channel=24.11&show=programs.steam.remotePlay.openFirewall

{ config, pkgs, ... }: { programs.steam = {

	# Whether to enable Steam.
	enable = true;

	# Whether to enable Load the extest library into Steam, to translate X11 input events to uinput events;
	# (e.g. for using Steam Input on Wayland).
	extest.enable = true;

	# Additional packages to add to the Steam environment.
	extraPackages = [ pkgs.unstable.gamescope pkgs.gamemode ];

	# Open ports in the firewall for Steam Remote Play.
	remotePlay.openFirewall = true;

}; }
