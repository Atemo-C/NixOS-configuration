{ config, ... }: { boot.loader = {
	limine = {
		# Whether to enable the Limine bootloader.
		enable = true;

		# Maximum number of latest NixOS generations to keep in the boot menu.
		# This can help prevent the boot partition from running out of disk space.
		maxGenerations = 16;
	};

	# Timeout in seconds until the first entry in the bootloader is activated.
	timeout = 1;
}; }