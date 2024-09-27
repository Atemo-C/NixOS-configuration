# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Bootloader
#
# Used NixOS options:
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.grub.configurationLimit
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.grub.device
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.grub.enable
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.timeout

{ config, ... }: { boot.loader = {

	grub = {
		# Maximum of configurations in boot menu.
		# GRUB has problems when there are too many entries.
		configurationLimit = 20;

		# The device on which the GRUB boot loader will be installed.
		# To install GRUB on multiple devices, use boot.loader.grub.devices.
		device = "/dev/sda";

		# Whether to enable the GNU GRUB boot loader.
		enable = true;
	};

	# Timeout in seconds until loader boots the default menu item.
	# Use null if the loader menu should be displayed indefinitely.
	timeout = 3;

}; }
