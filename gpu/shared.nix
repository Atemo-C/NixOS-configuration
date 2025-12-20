{ config, lib, pkgs, ... }: { hardware.graphics = {
	# Whether to enable hardware accelerated graphics drivers.
	enable = true;

	# Whether to also install 32-bit drivers for 32-bit programs.
	enable32Bit = true;

	# Additionally, consider adding extra packages for hardware acceleration with
	# `hardware.graphics.extraPackages = [];` in your device's `settings.nix` module.
	# There should be little to no conflicts when some/all are installed at once.
}; }