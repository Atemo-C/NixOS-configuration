{ config, pkgs, ... }: let printing = config.services.printing.enable; in {

	hardware.sane = {
		# Whether to enable support for SANE scanners.
		enable = printing;

#		# Which extra backends for SANE scanners to enable.
#		extraBackends = [ pkgs.hplipWithPlugin ];

#		# Disable certain SANE backends that can conflict with your devices.
#		disabledDefaultBackends = [ "escl" ];
	};

	# Printing and related networking services settings.
	services = {
		avahi = {
			# Run the Avahi daemon for device discovery.
			enable = printing;

			# Enable the mDNS NSS plug-in for IPv4.
			nssmdns4 = printing;

			# Open the firewall for UDP port 5353.
			openFirewall = printing;
		};

		printing = {
			# Whether to enable printing support through the CUPS daemaon.
			enable = true;

#			# Additional drivers, if needed.
			drivers = if printing then [
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
			] else [];
		};
	};

	# If printing is enabled, add the user to the relevant printing and scanning groups.
	users.users.${config.userName}.extraGroups = if printing then [ "lp" "scanner" ] else [];

	# If printing is enabled, install a simple scanning utility.
	environment.systemPackages = if printing then [ pkgs.simple-scan ] else [];

}
