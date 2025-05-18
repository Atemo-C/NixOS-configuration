{ config, lib, pkgs, ... }: let

	# Printing support; Toggleable in this module.
	printing = config.services.printing.enable;

in {

	services = {
		avahi = lib.optionalAttrs printing rec {
			# Whether to run the Avahi daemon for device discovery.
			# Also enables the mDNS NSS plug-in for IPv4 and opens port 5353 in the firewall.
			enable = true;
			nssmdns4 = enable;
			openFirewall = enable;
		};

		printing = {
			# Whether to enable printing support through the CUPS daemon.
			enable = true;

			# Additional drivers, if needed.
			drivers = lib.optionalAttrs printing [
#				pkgs.gutenprint                   # Drivers for many different printers from many different vendors.
#				pkgs.gutenprintBin                # Additional, binary-only drivers for some printers.
#				pkgs.hplip                        # Drivers for HP printers.
#				pkgs.hplipWithPlugin              # Drivers for HP printers, with the proprietary plugin (Unfree).
#				pkgs.postscript-lexmark           # Postscript drivers for Lexmark.
#				pkgs.samsung-unified-linux-driver # Proprietary Samsung Drivers (Unfree).
#				pkgs.splix                        # Drivers for printers supporting SPL (Samsung Printer Language).
#				pkgs.brlaser                      # Drivers for some Brother printers.
#				pkgs.brgenml1lpr                  # Generic drivers for more Brother printers (Unfree).
#				pkgs.cnijfilter2                  # Drivers for some Canon Pixma devices (Unfree).
#				pkgs.epson-escpr2                 # Drivers for newer Epson devices.
#				pkgs.epson-escpr                  # Drivers for some other Epson devices.
			];
		};
	};

	# Add the user to the relevant printing and scanning groups.
	users.users.${config.userName}.extraGroups = lib.optionalAttrs printing [ "lp" "scanner" ];

	# Install a simple scanning utility.
	environment.systemPackages = lib.optionalAttrs printing [ pkgs.simple-scan ];

}
