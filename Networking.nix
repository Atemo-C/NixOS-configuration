{ config, pkgs, ... }: {

	networking = {
		# Specifies when the dhcpcd device will fork to background.
		# background, any, ipv4, ipv6, both, if-carrier-up
		dhcpcd.wait = "background";

		# Whether to enable networking using NetworkManager.
		networkmanager.enable = true;
	};

	# Whether to enable the NetworkManager control applet.
	programs.nm-applet.enable = true;

	# If you prefer to start it manually, you can install the package alone.
#	environment.systemPackages = [ pkgs.networkmanagerapplet ];

	# Whether to enable NetworkManager's "wait-online" service.
	systemd.services.NetworkManager-wait-online.enable = false;

	# Adds the user in the "networkmanager" group for managing NetworkManager settings.
	users.users.${config.custom.name}.extraGroups = [ "networkmanager" ];

}
