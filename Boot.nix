{ config, pkgs, ... }: {

	boot.loader = {
		limine = {
			# Whether to enable the Limine bootloader.
			enable = true;

			# If booting in BIOS mode, select the drive to install the bootloader onto.
			# You can see its name by doing `ls /dev/disk/by-id`.
#			biosDevice = if ! pkgs.stdenv.hostPlatform.isEfi then "/dev/disk/by-id/disk-here" else "nodev";

			# Maximum number of latest NixOS generations to keep in the boot menu.
			# This prevents the boot partition from running out of disk space.
			maxGenerations = 48;
		};

		# Timeout, in seconds, until the first entry in the bootloader is activated.
		timeout = 10;

		# If on an EFI system, allow the installation process to modify EFI boot variables.
		efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isEfi;
	};

	# If on an EFI system, install a utility to manually modify the EFI boot manager and its entries.
	environment.systemPackages = if pkgs.stdenv.hostPlatform.isEfi then [ pkgs.efibootmgr ] else [];

}
