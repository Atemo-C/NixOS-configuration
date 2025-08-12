{ config, lib, pkgs, ... }: {
	# Whether to allow installation of unfree (proprietary) software.
	nixpkgs.config.allowUnfree = true;

	# Whether to enable the Flatpak packaging system.
	# XDG portals need to be configured.
	services.flatpak.enable = true;

	# Activate necessary GTK desktop portals for Flatpak.
	xdg.portal = lib.mkIf config.services.flatpak.enable {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = [ pkgs.xdg-desktop-portal-gtk ];

		# Additional Portals to add to the path.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

		# Enable XDG Desktop integartation, a must for Flatpaks.
		enable = true;
	};

	# Add shell abbreviations for enabling the Flathub repository and to update Flatpaks.
	programs.fish.shellAbbrs = lib.mkIf (config.programs.fish.enable && config.services.flatpak.enable) rec {
		# Enable the Flathub repository.
		enable-flathub = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";

		# Upgrade Flatpaks.
		update-flatpak = "flatpak update -y && flatpak remove --unused -y";
		flatpak-update = update-flatpak;
		upgrade-flatpak = update-flatpak;
		flatpak-upgrade = update-flatpak;
	};
}