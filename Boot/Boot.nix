{ config, ... }: { boot.loader = {

	# Whether the installation process is allowed to modify EFI boot variables.
	# Only use on EFI-booted devices.
	efi.canTouchEfiVariables = true;

	# Timeout in seconds until the first entry in the bootloader is activated.
	timeout = 3;

	# Limine bootloader configuration.
	limine = {
		# Whether to enable the Limine bootloader.
		enable = true;

		# Maximum number of latest generations to show in the boot menu.
		# Useful to prevent the boot partition from running out of disk space.
		maxGenerations = 50;
	};

}; }
