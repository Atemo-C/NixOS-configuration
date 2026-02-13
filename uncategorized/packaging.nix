{ config, lib, pkgs, ... }: rec {
	# Whether to allow installation of unfree (proprietary) software.
	nixpkgs.config.allowUnfree = true;

	# If the above is enabled, also apply this rule to temporary nix shell instances.
	environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf nixpkgs.config.allowUnfree "1";

	services.flatpak = {
		# Whether to enable the Flatpak packaging system.
		# The GTK desktop needs to be configured.
		enable = true;

		# Flatpak programs for managing Flatpak applications and permissions.
		packages = [
			"com.github.tchx84.Flatseal"
			"io.github.flattool.Warehouse"
		];
	};

	# Configure XDG Desktop Portals for Flatpak.
	xdg.portal = lib.mkIf services.flatpak.enable {
		configPackages = [ pkgs.xdg-desktop-portal-gtk ];
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
		enable = true;
	};

	# Import the Nix Flatpak module if using Flatpaks.
	imports = lib.optional services.flatpak.enable ../extra-modules/external/nix-flatpak.nix;

	# Add shell abbreviations for managing Flatpak.
	programs.fish.shellAbbrs = lib.mkIf services.flatpak.enable rec {
		# Upgrade flatpaks and remove unsused ones.
		update-flatpak  = "flatpak update -y && flatpak remove --unsused -y";
		flatpak-update  = update-flatpak;
		upgrade-flatpak = update-flatpak;
		flatpak-upgrade = update-flatpak;

		# Removing flatpaks.
		flatpak-remove = "flatpak remove";
		remove-flatpak = flatpak-remove;
		flatpak-purge  = "flatpak remove --delete-data";
		purge-flatpak  = flatpak-purge;
	};
}