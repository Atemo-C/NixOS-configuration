# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Printing
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=services.avahi.enable
# • https://search.nixos.org/options?channel=24.11&show=services.avahi.nssmdns4
# • https://search.nixos.org/options?channel=24.11&show=services.avahi.openFirewall
# • https://search.nixos.org/options?channel=24.11&show=services.printing.enable
# • https://search.nixos.org/options?channel=24.11&show=hardware.sane.enable
# • https://search.nixos.org/options?channel=24.11&show=users.users.<name>.extraGroups
#
# Used NixOS packages:
#─────────────────────
# • [simple-scan]
#   https://gitlab.gnome.org/GNOME/simple-scan


{ config, pkgs, ... }: {

	# Simple scanning utility.
	environment.systemPackages = [ pkgs.simple-scan ];

	services = {
		avahi = {
			# Whether to run the Avahi daemon.
			enable = true;

			# Whether to enable the mDNS NSSplug-in for IPv4.
			nssmdns4 = true;

			# Whether to open the firewall for UDP port 5353.
			openFirewall = true;
		};
		# Whether to enable printing support through the CUPS daemon.
		printing.enable = true;
	};

	# Enable support for SANE scanners.
	hardware.sane.enable = true;

	# User's auxilary groups for printing and scanning.
	users.users.${config.custom.name}.extraGroups = [ "lp" "scanner" ];

}
