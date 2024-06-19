{ config, pkgs, ... }: {

	programs.gamescope = {
		# Whether to enable the Gamescope Wayland microcompositor.
		# https://search.nixos.org/options?channel=24.05&show=programs.gamescope.enable
		enable = true;

		# The gamescope package to use.
		# https://search.nixos.org/options?channel=24.05&show=programs.gamescope.package
		package = pkgs.unstable.gamescope;
	};

}
