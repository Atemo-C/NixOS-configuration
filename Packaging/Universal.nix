# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Appimage
# • https://wiki.nixos.org/wiki/Flatpak
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=services.flatpak.enable
#
# Used NixOS packages:
#─────────────────────
# • [appimage-run]
#   https://search.nixos.org/packages?channel=24.05&show=appimage-run

{ config, pkgs, ... }: {

	# Use AppImages with the appimage-run command.
	environment.systemPackages = [ pkgs.appimage-run ];

	# Whether to enable Flatpak.
	services.flatpak.enable = true;

}
