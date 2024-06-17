{ config, pkgs, ... }: {

	# Which version of the Linux Kernel to be used by NixOS.
	# https://search.nixos.org/options?channel=24.05&show=boot.kernelPackages
	boot.kernelPackages = pkgs.unstable.linuxPackages_zen;

}
