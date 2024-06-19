{ config, lib, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# GNOME's disk utility.
		gnome.gnome-disk-utility

		# Partition manager.
		gparted

		# Get ATA/SATA drive parameters.
		hdparm

		# Bootable medium management.
		ventoy-full
	];

	services = {
		# Whether to enable the smartd daemon from the smartmontools package.
		# https://search.nixos.org/options?channel=unstable&show=services.smartd.enable
		smartd.enable = true;

		# Whether to enable the udisks2 DBus service.
		# https://search.nixos.org/options?channel=unstable&show=services.udisks2.enable
		udisks2.enable = true;
	};

}
