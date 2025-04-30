{ config, pkgs, ... }: let Printing = config.services.printing.enable; in {

	hardware.sane = {
		# Whether to enable support for SANE scanners.
		enable = Printing;

#		# Enable extra backends for SANE scanners.
#		extraBackends = [ ];

#		# Disable certain SANE backends that can conflict with your devices.
#		disabledDefaultBackends = [ ];
	};

	# Printing and related networking services settings.
	services = {
		avahi = {
			# Run the Avahi daemon for device discovery.
			enable = Printing;

			# Enable the mDNS NSS plug-in for IPv4.
			nssmdns4 = Printing;

			# Open the firewall for UDP port 5353.
			openFirewall = Printing;
		};

		printing = {
			# Enable printing support through the CUPS daemaon.
			enable = true;

#			# Additional drivers, if needed.
			drivers = [
#				pkgs.gutenprint                   # Drivers for many different printers from many different vendors.
#				pkgs.gutenprintBin                # Additional, binary-only drivers for some printers.
#				pkgs.hplip                        # Drivers for HP printers.
#				pkgs.hplipWithPlugin              # Drivers for HP printers, with the proprietary plugin.
#				pkgs.postscript-lexmark           # Postscript drivers for Lexmark.
#				pkgs.samsung-unified-linux-driver # Proprietary Samsung Drivers.
#				pkgs.splix                        # Drivers for printers supporting SPL (Samsung Printer Language)..
#				pkgs.brlaser                      # Drivers for some Brother printers.
#				pkgs.brgenml1lpr                  # v Generic drivers for more Brother printers.
#				pkg.sbrgenml1cupswrapper          # ^ Generic drivers for more Brother printers.
#				pkgs.cnijfilter2                  # Drivers for some Canon Pixma devices.
			];
		};
	};

	# If printing is enabled, add the user to the relevant printing and scanning groups.
	users.users.${config.userName}.extraGroups = if Printing then [ "lp" "scanner" ] else [];

	# If printing is enabled, install a simple scanning utility.
	environment.systemPackages = if Printing then [ pkgs.simple-scan ] else [];

}
