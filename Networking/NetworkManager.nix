{ config, ... }: {

	# Whether to use NetworkManager to manage network interfaces.
	# https://search.nixos.org/options?channel=24.05&show=networking.networkmanager.enable
	networking.networkmanager.enable = true;

}
