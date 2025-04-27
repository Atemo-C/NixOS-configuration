{ config, pkgs, ... }: {

	boot.loader = {
		# Limine bootloader configuration.
		limine = {
			# Enable the Limine bootloader.
			enable = true;

			# Maximum number of latest NixOS generations to keep in the boot menu.
			# This prevents the boot partition from running out of disk space.
			maxGenerations = 48;
		};

		# Timeout, in seconds, until the first entry in the bootloader is activated.
		timeout = 10;

		# Allow the installation process to modify EFI boot variables if on an EFI system.
		efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isEfi;
	};

	# Utilitiy to manually modify the EFI boot manager and its entries.
	environment.systemPackages = [ (if pkgs.stdenv.hostPlatform.isEfi then pkgs.efibootmgr else null) ];

}
