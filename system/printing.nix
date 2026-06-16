{ config, lib, pkgs, ... }: let prt = config.services.printing.enable; in {
	# Simple scanning utility.
	environment.systemPackages = lib.optional prt pkgs.simple-scan;

	services = {
		printing = {
			# Whether to enable printing support through the CUPs daemon.
			enable = true;

			# Additional drivers to install.
			drivers = with pkgs; [
#				gutenprint                   # Drivers for many different printers from many different vendors.
#				gutenprintBin                # Additional, binary-only drivers for some printers.
#				hplip                        # Drivers for HP printers.
#				hplipWithPlugin              # Drivers for HP printers, with the proprietary plugin.
#				postscript-lexmark           # Postscript drivers for Lexmark.
#				samsung-unified-linux-driver # Proprietary Samsung Drivers.
#				splix                        # Drivers for printers supporting SPL (Samsung Printer Language).
#				brlaser                      # Drivers for some Brother printers.
#				brgenml1lpr                  # Generic drivers for more Brother printers (Unfree).
#				cnijfilter2                  # Drivers for some Canon Pixma devices (Unfree).
#				epson-escpr2                 # Drivers for newer Epson devices.
#				epson-escpr                  # Drivers for some other Epson devices.
			];
		};
	} // (lib.mkIf prt {
		# Whether to run the Avahi daemon to allow for network printer discovery.
		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
	});

	# Add the user to the `lp` and `scanner` groups.
	users.users.${config.user.name}.extraGroups = lib.optionals prt [ "lp" "scanner" ];
}