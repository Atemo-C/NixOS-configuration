{ config, pkgs, ... }: {

	programs.steam = {
		# Whether to enable Steam.
		# https://search.nixos.org/options?channel=24.05&show=programs.steam.enable
		enable = true;
	};

}
