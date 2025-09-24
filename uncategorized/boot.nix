{ ... }: { boot.loader = {
	# Whether to let the boot loader modify EFI entries.
	efi.canTouchEfiVariables = true;

	# Whether to enable the Limine bootloader.
	limine.enable = true;

	# Maximum number of latest NixOS generations to keep in the boot menu.
	# This can help prevent the boot partition from running out of disk space.
	limine.maxGenerations = 16;

	# Timeout in seconds until the first entry in the bootloader is activated.
	timeout = 1;
}; }