{ config, lib, ... }: {
	networking = {
		# Fork the dhcpcd device to the background to improve boot times.
		dhcpcd.wait = "background";

		networkmanager = {
			# Whether to enable NetworkManager for easy network management.
			enable = true;

			# Set the DNS resolver to be used.
			dns = lib.mkIf config.services.resolved.enable "systemd-resolved";
		};

		stevenblack = {
			# Whether to enable stevenblack hosts file blocking.
			enable = true;

			# Additional blocklist extensions to enable.
			block = [ "fakenews" "gambling" ];
		};
	};

	# Install an applet to configure the networking within the system tray.
	programs.nm-applet.enable = lib.mkIf config.networking.networkmanager.enable true;

	services = {
		resolved = {
			# Whether to enable the systemd-resolved DNS resolver.
			enable = true;

			# Whether to use DNS-over-TLS.
			settings.Resolve.DNSOverTLS = true;
		};

		timesyncd = {
			# Main server to sync time with.
			servers = [ "time.cloudflare.com" ];

			# Fallback servers to sync time with.
			fallbackServers = [
				"time.google.com"
				"0.arch.pool.ntp.org"
				"1.arch.pool.ntp.org"
				"2.arch.pool.ntp.org"
				"3.arch.pool.ntp.org"
			];
		};
	};

	# Disable NetworkManager's `wait-online` service to improve boot times.
	# If something relies on networking as soon as possible during boot, set to `true`.
	systemd.services.NetworkManager-wait-online.enable = false;

	# Add the user to the `networkmanager` group for NetworkManager control.
	users.users.${config.userName}.extraGroups = lib.optinoal config.networking.networkmanager.enable "networkmanager";
}