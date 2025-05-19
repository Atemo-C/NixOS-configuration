{ config, lib, pkgs, ... }: let

	# Network management with NetworkManager; Toggleable in this module.
	networkmanager = config.networking.networkmanager.enable;

	# Hyprland check for the nm-applet program.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

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

	# Add the user to the `networkmanager` group.
	users.users.${config.userName}.extraGroups = lib.optionalAttrs networkmanager [ "networkmanager" ];

	# Disable NetworkManager's `wait-online` service to improve boot times.
	systemd.services.NetworkManager-wait-online.enable = lib.optionalAttrs networkmanager false;

	# Disable NetworkManager's `ModemManager` service if not using cellular connections.
	systemd.services.ModemManager.enable = lib.optionalAttrs networkmanager false;

	# Add an applet to configure the network graphically in Hyprland.
	programs.nm-applet.enable = lib.optionals (networkmanager && hyprland) true;

}
