{ config, pkgs, ... }: let flatpak = config.services.flatpak.enable; in {

	# Whether to allow installation of unfree software.
	nixpkgs.config.allowUnfree = true;

	# Windows software compatibility using Bottles.
	# Using the FLatpak version might provide a better experience.
	environment.systemPackages = [ (pkgs.bottles.override { removeWarningPopup = true; }) ];

	# AppImage support.
	programs.appimage = {
		# Whether to enable binfmt registration to run appimages via appimage-run seamlessly.
		binfmt = true;

		# Whether to enable the appimage-run wrapper script for executing AppImages on NixOS.
		enable = true;
	};

	# Whether to enable the Flatpak packaging system.
	services.flatpak.enable = true;

	# If Flatpak is enabled, configure basic XDG Desktop Portals.
	xdg.portal = if flatpak then {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = [ pkgs.xdg-desktop-portal-gtk ];

		# Additional Portals to add to the path.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

		# Enable XDG Desktop integartation, a must for Flatpaks.
		enable = true;
	} else {};

}
