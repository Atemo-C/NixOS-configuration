{ config, pkgs, ... }: let

	Networking = config.networking.networkmanager.enable;
	Hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		# Name of the system over the Network.
		# [a-z] [A-Z] [0-9] [ - ]
		hostName = "COMPUTER-HERE";

		# Whether to enable NetworkManager for easy networking.
		networkmanager.enable = true;
	};

	# Add the user to the `networkmanager` group if NetworkManager is enabled.
	users.users.${config.userName}.extraGroups = if Networking then [ "networkmanager" ] else [];

	# Disable NetworkManager's `wait-online` service to improve boot times.
	systemd.services.NetworkManager-wait-online.enable = (if Networking then false else null);

	# Add an applet to control NetworkManager graphically if both it and Hyprland are enabled.
	programs.nm-applet.enable = Networking && Hyprland;

}
