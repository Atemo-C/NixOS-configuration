{ config, pkgs, ... }: {

	# Allow the use of unstable packages by using `pkgs.unstable.package-name`.
	# https://search.nixos.org/options?channel=24.05&show=nixpkgs.config
	#
	# Before this can be used, one must run the following commands once:
	#   sudo nix-channel --add https://nixos.org/channels/nixos-untsable nixos-unstable
	#   sudo nix-channel --update
	nixpkgs.config.packageOverrides = pkgs: {
		unstable = import <nixos-unstable> {
			config = config.nixpkgs.config;
		};
	};

}
