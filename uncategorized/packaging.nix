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

	# Enable Flathub globally if not already present.
	systemd.services.flatpak-repo = lib.mkIf config.services.flatpak.enable {
		wantedBy = [ "multi-user.target" ];
		path = [ pkgs.flatpak ];
		script = ''flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'';
	};

	# Add shell abbreviations for updating flatpaks.
	programs.fish.shellAbbrs = lib.mkIf (config.programs.fish.enable && config.services.flatpak.enable) rec {
		update-flatpak = "flatpak update -y && flatpak remove --unused -y";
		flatpak-update = update-flatpak;
		upgrade-flatpak = update-flatpak;
		flatpak-upgrade = update-flatpak;
	};
}