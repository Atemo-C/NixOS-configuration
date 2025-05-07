{ config, pkgs, ... }: let

	networkmanager = config.networking.networkmanager.enable;
	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		# Name of the system over the Network.
		# [a-z] [A-Z] [0-9] [ - ]
		hostName = "COMPUTER-NAME";

		# Whether to enable NetworkManager for easy networking.
		networkmanager.enable = true;
	};

	# If NetworkManager is enabled, add the user to the `networkmanager` group.
	users.users.${config.userName}.extraGroups = if networkmanager then [ "networkmanager" ] else [];

	# Disable NetworkManager's `wait-online` service to improve boot times.
	systemd.services.NetworkManager-wait-online.enable = if networkmanager then false else null;

	# If Hyprland & NetworkManager are enabled, add an applet to configure the network graphically.
	programs.nm-applet.enable = networkmanager && hyprland;

}
