{ config, lib, pkgs, ... }: {
	services = rec {
		printing = {
			# Whether to enable printing support through the CUPS daemon.
			enable = true;

			# Additional drivers.
			drivers = lib.optionals printing.enable (with pkgs; [
				#gutenprint                   # Drivers for many different printers from many different vendors.
				#gutenprintBin                # Additional, binary-only drivers for some printers.
				#hplip                        # Drivers for HP printers.
				hplipWithPlugin              # Drivers for HP printers, with the proprietary plugin.
				#postscript-lexmark           # Postscript drivers for Lexmark.
				#samsung-unified-linux-driver # Proprietary Samsung Drivers.
				#splix                        # Drivers for printers supporting SPL (Samsung Printer Language).
				#brlaser                      # Drivers for some Brother printers.
				#brgenml1lpr                  # Generic drivers for more Brother printers (Unfree).
				#cnijfilter2                  # Drivers for some Canon Pixma devices (Unfree).
				#epson-escpr2                 # Drivers for newer Epson devices.
				#epson-escpr                  # Drivers for some other Epson devices.
			]);
		};
		avahi = lib.mkIf printing.enable rec {
			# Whether to run the Avahi daemon for printer/scanner device discovery.
			enable = true;

			# Whether to enable the mDNS & NSS plug-in for IPv4.
			nssmdns4 = lib.mkIf enable true;

			# Whether to open the port 5353 in the firewall for remote printers.
			openFirewall = lib.mkIf enable true;
		};
	};

	# Add the user to printing and scanning groups.
	users.users.${config.userName}.extraGroups = lib.optionals config.services.printing.enable [ "lp" "scanner" ];

	# Scanning utility.
	environment.systemPackages = lib.optional (config.programs.niri.enable && config.services.printing.enable) pkgs.simple-scan;
}