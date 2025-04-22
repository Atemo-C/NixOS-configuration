{ config, ... }: {

	# Whether to save disk space by hard-linking files in the store that have identical contents.
	nix.settings.auto-optimise-store = true;

	# Whether to allow installation of unfree packages.
	nixpkgs.config.allowUnfree = true;

	# Enable the nix-command feature.
	nix.settings.experimental-features = [ "nix-command" ];

}
