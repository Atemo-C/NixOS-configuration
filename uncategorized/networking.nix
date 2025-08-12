{ config, lib, pkgs, ... }: {
	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		# Whether to enable NetworkManager for easy network management.
		networkmanager.enable = true;
	};

	# Add the user to the `networkmanager` group for NetworkManager control.
	users.users.${config.userName}.extraGroups = lib.optional config.networking.networkmanager.enable "networkmanager";

	# Install an applet to graphically configure the network within the system tray.
	programs.nm-applet.enable = lib.mkIf (config.networking.networkmanager.enable && config.programs.niri.enable) true;
}