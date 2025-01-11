{ config, ... }: { boot.loader.grub = {

	# Limit of generations that appear in the boot menu.
	configurationLimit = 20;

	# Device where the boot loader should be installed.
	device = "/dev/sda";

	# Whether to enable the boot loader.
	enable = true;

	# Whether to make the memtest86 memory testing program available in the boot menu.
	memtest86.enable = true;

	# Whether to append entries for other detected operating systems.
	useOSProber = true;

}; }
