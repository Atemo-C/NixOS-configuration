{ config, ... }: { boot.loader = {

	# Whether the installation process is allowed to modify EFI boot variables.
	efi.canTouchEfiVariables = true;

	systemd-boot = {
		# Limit of generations that appear in the boot menu.
		configurationLimit = 20;

		# The resolution of the console.
		consoleMode = "max";

		# Whether to allow editing the kernel command-line before boot.
		# For security reasons, it is recommended to keep it to false.
		editor = false;

		# Whether to enable the boot loader.
		enable = true;

		# Whether to make the memtest86 memory testing program available in the boot menu.
		memtest86.enable = true;
	};

}; }
