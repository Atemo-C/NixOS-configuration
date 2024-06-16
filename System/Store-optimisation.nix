{ config, ... }: {

	# If true, Nix detects duplicate files in the store and replaces them with hard links to a single copy.
	# https://search.nixos.org/options?channel=24.05&show=nix.settings.auto-optimise-store
	nix.settings.auto-optimise-store = true;

}
