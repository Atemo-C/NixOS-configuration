{ config, lib, ... }: {
	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		# Whether to enable NetworkManager for easy network management.
		networkmanager.enable = true;

		stevenblack = {
			# Whether to enable stevenblack hosts file blocking.
			enable = true;

			# Additional blocklist extensions to enable.
			block = [ "fakenews" "gambling" ];
		};
	};

	# Install an applet to configure the networking within the system tray.
	programs.nm-applet.enable = lib.mkIf config.networking.networkmanager.enable true;

	# Disable NetworkManager's `wait-online` service to improve boot times.
	# If something relies on networking as soon as possible during boot, set to `true`.
	systemd.services.NetworkManager-wait-online.enable = false;

	# Add the user to the `networkmanager` group for NetworkManager control.
	users.users.${config.userName}.extraGroups = lib.optional config.networking.networkmanager.enable "networkmanager";
}