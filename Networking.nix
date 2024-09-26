# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Networking
# • https://wiki.nixos.org/wiki/NetworkManager
#
# Used NixOS packages:
#─────────────────────
# • [networkmanagerapplet]
#   https://gitlab.gnome.org/GNOME/network-manager-applet/
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=networking.hostName
# • https://search.nixos.org/options?channel=24.05&show=networking.networkmanager.enable
# • https://search.nixos.org/options?channel=24.05&show=systemd.services
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.extraGroups

{ config, pkgs, ... }: {

	# NetworkManager control applet.
	environment.systemPackages = [ pkgs.networkmanagerapplet ];

	networking = {
		# The name of the machine.
		hostName = "R5-PC";

		# Whether to use NetworkManager to manage network interfaces.
		networkmanager.enable = true;
	};

	# Whether to enable NetworkManager's "wait-online" service.
	systemd.services.NetworkManager-wait-online.enable = false;

	# Adds the user in the "networkmanager" group for managing NetworkManager settings.
	users.users.${config.custom.name}.extraGroups = [ "networkmanager" ];

}
