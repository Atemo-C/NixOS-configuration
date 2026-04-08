{ config, lib, pkgs, ... }: {
	services.printing = {
		enable = true;
		drivers = with pkgs; [
#			gutenprint                   # Drivers for many different printers from many different vendors.
#			gutenprintBin                # Additional, binary-only drivers for some printers.
#			hplip                        # Drivers for HP printers.
#			hplipWithPlugin              # Drivers for HP printers, with the proprietary plugin.
#			postscript-lexmark           # Postscript drivers for Lexmark.
#			samsung-unified-linux-driver # Proprietary Samsung Drivers.
#			splix                        # Drivers for printers supporting SPL (Samsung Printer Language).
#			brlaser                      # Drivers for some Brother printers.
#			brgenml1lpr                  # Generic drivers for more Brother printers (Unfree).
#			cnijfilter2                  # Drivers for some Canon Pixma devices (Unfree).
#			epson-escpr2                 # Drivers for newer Epson devices.
#			epson-escpr                  # Drivers for some other Epson devices.
		];
	};

	config = lib.mkIf config.services.printing.enable {
		services.avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};

		programs.simple-scan.enable = true;
		users.users.${config.user.name}.extraGroups = [ "lp" "scanner" ];
	};
}