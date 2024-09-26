# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Bootloader
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.efi.canTouchEfiVariables
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.configurationLimit
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.editor
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.enable
# • https://search.nixos.org/options?channel=24.05&show=boot.loader.timeout

{ config, ... }: { boot.loader = {

	# Whether the installation process is allowed to modify EFI boot variables.
	efi.canTouchEfiVariables = true;

	systemd-boot = {
		# Maximum number of latest generations in the boot menu.
		# Useful to prevent boot partition running out of disk space.
		configurationLimit = 10;

		# Whether to allow editing the kernel command-line before boot.
		# It allows gaining root access by passing init=/bin/sh as a kernel, so it is recommended to turn it off.
		# However, it is enabled by default in NixOS for backwards compatibility.
		editor = false;

		# Whether to enable the systemd-boot (formerly gummiboot) EFI boot manager.
		enable = true;
	};

	# Timeout (in seconds) until loader boots the default menu item.
	# Use null if the loader menu should be displayed indefinitely.
	timeout = 3;

}; }
