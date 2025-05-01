{ config, pkgs, ... }: let EFI = pkgs.stdenv.hostPlatform.isEfi; in {

	boot.loader = {
		limine = {
			# Whether to enable the Limine bootloader.
			enable = true;

			# If booting in BIOS mode, select the drive to install Limine onto.
			# You can see its name by running the command `ls /dev/disk/by-id`.
#			biosDevice = if EFI then "nodev" else "nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0W519865N";

			# Maximum number of latest NixOS generations to keep in the boot menu.
			# This prevents the boot partition from running out of disk space.
			maxGenerations = 48;
		};

		# Timeout, in seconds, until the first entry in the bootloader is activated.
		timeout = 10;

		# If on an EFI system, allow the installation process to modify EFI boot variables.
		efi.canTouchEfiVariables = EFI;
	};

	# If on an EFI system, install a utility to manually modify the EFI boot manager and its entries.
	environment.systemPackages = if EFI then [ pkgs.efibootmgr ] else [];

}
