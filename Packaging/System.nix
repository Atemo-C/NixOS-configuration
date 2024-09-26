# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=nix.settings.auto-optimise-store
# • https://search.nixos.org/options?channel=24.05&show=nixpkgs.config.allowUnfree
# • https://search.nixos.org/options?channel=24.05&show=system.stateVersion

{ config, ... }: {

	# If set to true, Nix automatically detects files in the store that have identical contents, and replaces them with
	# hard links to a single copy.
	nix.settings.auto-optimise-store = true;

	# Allow installation of unfree packages.
	nixpkgs.config.allowUnfree = true;

	# Which version of NixOS was installed on this computer. It is important to read more at the link below.
	system.stateVersion = "24.05";

}
