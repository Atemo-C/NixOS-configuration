{ config, ... }: {

	# Allow unfree packages.
	# https://search.nixos.org/options?channel=24.05&show=nixpkgs.config
	nixpkgs.config.allowUnfree = true;

}
