{ config, pkgs, ... }: { boot = {

	# Change the compression type of the initramfs to improve boot times.
	# The effect is only really noticeable on old hardware.
	initrd.compressor = "cat";

	# Override the Linux kernel used by NixOS.
	kernelPackages = pkgs.linuxPackages_zen;

}; }
