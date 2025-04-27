{ config, ... }: rec {

	boot.loader = {
		# Limine bootloader configuration.
		limine = {
			# Whether to enable the Limine bootloader.
			enable = true;

			# Maximum number of latest NixOS generations to show in the boot menu.
			# This is useful to prevent tho boot partition from running out of disk space.
			maxGenerations = 48;
		};

		# Timeout, in seconds, until the first entry in the bootloader is activated.
		timeout = 10;

		# If on an EFI system, allow the installation process to modify EFI boot variables.
		efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isEfi;
	};

	# If on an EFI system, install a user-space application to allow manually modifying the EFI Boot Manager.
	environment.systemPackages = [ (if boot.loader.limine.efiSupport then pkgs.efibootmgr else null) ];

}
