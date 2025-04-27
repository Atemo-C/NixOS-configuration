{ config, pkgs, ... }: rec {

	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		# Name of the system over the network.
		# [a-z] [A-Z] [0-9] [ - ]
		hostName = "COMPUTER-NAME";

		# Whether to enable NetworkManager for easy networking.
		networkmanager.enable = true;
	};

	# If NetworkManager is enabled, add the user to the `networkmanager` group.
	users.users.${config.userName}.extraGroups = [
		( if networking.networkmanager.enable then "networkmanager" else null)
	];

	# Disable NetworkManager's `wait-online` service to improve boot times.
	systemd.services.NetworkManager-wait-online.enable = (if networking.networkmanager.enable then false else null);

	# If NetworkManager and the Hyprland Wayland compositor are enabled, add an applet to control network graphically.
	programs.nm-applet.enable =
		networking.networkmanager.enable && home-manager.users.${config.userName}wayland.windowManager.hyprland.enable;

}
