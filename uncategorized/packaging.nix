{ config, lib, pkgs, ... }: rec {
	# Whether to allow installation of unfree (proprietary) software.
	nixpkgs.config.allowUnfree = true;

	# If the above is enabled, also apply this rule to temporary nix shell instances.
	environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf nixpkgs.config.allowUnfree "1";

	services.flatpak = {
		# Whether to enable the Flatpak packaging system.
		# The GTK desktop needs to be configured; However, Niri does it already for us here.
		enable = true;

		# Flatpak programs for managing Flatpak applications and permissions.
		packages = [
			"com.github.tchx84.Flatseal"
			"io.github.flattool.Warehouse"
		];
	};

	# Import the Nix Flatpak module if using Flatpaks.
	imports = lib.mkIf services.flatpak.enable [ /etc/nixos/extra-modules/external/nix-flatpak.nix ];

	# Add shell abbreviations for managing Flatpak.
	programs.fish.shellAbbrs = lib.mkIf services.flatpak.enable rec {
		# Upgrade flatpaks and remove unsused ones.
		update-flatpak  = "flatpak-update -y && flatpak remove --unsused -y";
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