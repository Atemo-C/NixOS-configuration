{ config, lib, ... }: {
	# Fork the dhcpcd device to the background to improve boot times.
	networking.dhcpcd.wait = "background";

	# Whether to enable NetworkManager for easy network management.
	networking.networkmanager.enable = true;

	# Add the user to the `networkmanager` group for NetworkManager control.
	users.users.${config.userName}.extraGroups = lib.optional config.networking.networkmanager.enable "networkmanager";

	# Disable NetworkManager's `wait-online` service to improve boot times.
	# If some services rely on Networking as soon as possible, set it to true.
	systemd.services.NetworkManager-wait-online.enable = lib.mkIf config.networking.networkmanager.enable true;

	# Install an applet to graphically configure the network within the system tray.
	programs.nm-applet.enable = lib.mkIf (config.networking.networkmanager.enable && config.programs.niri.enable) true;

	networking.stevenblack = {
		# Whether to enable stevenblack hosts file blocklist.
		enable = true;

		# Additional blocklist extensions to enable.
		block = [
			"fakenews"
			"gambling"
		];
	};
}