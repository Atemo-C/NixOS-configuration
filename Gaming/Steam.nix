{ config, pkgs, ... }: {

	programs.steam = {
		# Whether to enable Steam.
		# https://search.nixos.org/options?channel=24.05&show=programs.steam.enable
		enable = true;

		# Open ports in the firewall for Steam Remote Play.
		# https://search.nixos.org/options?channel=24.05&show=programs.steam.remotePlay.openFirewall
		remotePlay.openFirewall = true;
	};

}
