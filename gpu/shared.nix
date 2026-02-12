{ config, lib, pkgs, ... }: { hardware.graphics = {
	# Whether to enable hardware accelerated graphics drivers.
	enable = true;

	# Whether to also install 32-bit drivers for 32-bit programs.
	enable32Bit = true;
}; }