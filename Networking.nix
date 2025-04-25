{ config, pkgs, ... }: rec {

	networking = {
		# Specifices when the dhcpcd device will fork to background.
		# Can be one of: background, any, ipv6, both, if-carrier-up.
		# Select `background` for faster boot times.
		dhcpcd.wait = "background";

		# Name of the system.
		# [a-z] [A-Z] [0-9] [ - ]
		hostName = "COMPUTER-NAME";

		# Whether to enable easy networking using NetworkManager.
		networkmanager.enable = true;
	};

	# If NetworkManager is enabled, disable NetworkManager's "wait-online" service.
	# This improves boot times.
	systemd.services.NetworkManager-wait-online.enable = ( if networking.networkmanager.enable then false else null );

	# If NetworkManager is enabled, add the user to the NetworkManager group to allow managing it.
	users.users.${config.userName}.extraGroups = [
		( if networking.networkmanager.enable then "networkmanager" else null )
	];

	# If NetworkManager is enabled, enable the NetworkManager control applet in graphical environments.
	programs.nm-applet.enable = networking.networkmanager.enable;

}
