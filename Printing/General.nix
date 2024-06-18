{ config, ... }: {

	services = {
		avahi = {

			# Whether to run the Avahi daemon.
			# https://search.nixos.org/options?channel=24.05&show=services.avahi.enable
			enable = true;

			# Whether to enable the mDNS NSSplug-in for IPv4.
			# https://search.nixos.org/options?channel=24.05&show=services.avahi.nssmdns4
			nssmdns4 = true;

			# Whether to open the firewall for UDP port 5353.
			# https://search.nixos.org/options?channel=24.05&show=services.avahi.openFirewall
			openFirewall = true;
		};
		# Whether to enable printing support through the CUPS daemon.
		# https://search.nixos.org/options?channel=24.05&show=services.printing.enable
		printing.enable = true;
	};

	# Enable support for SANE scanners.
	# https://search.nixos.org/options?channel=24.05&show=hardware.sane.enable
	hardware.sane.enable = true;

	# User's auxilary groups for printing and scanning.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.${config.Custom.Name}.extraGroups = [
		"lp"
		"scanner"
	];

}
