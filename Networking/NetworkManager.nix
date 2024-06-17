{ config, pkgs, ... }: {

	# Graphical applet to configure the network.
	environment.systemPackages = with pkgs; [ networkmanagerapplet ];

	# Whether to use NetworkManager to manage network interfaces.
	# https://search.nixos.org/options?channel=24.05&show=networking.networkmanager.enable
	networking.networkmanager.enable = true;

	# Disable NetworkManager's "wait-online" service.
	systemd.services.NetworkManager-wait-online.enable = false;

	# User's auxilary groups for NetworkManager.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.username.extraGroups = [ "networkmanager" ];

}
