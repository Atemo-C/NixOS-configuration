{ config, lib, pkgs, ... }: {
	boot = {
		# Select the Linux Kernel version to use.
		# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
		kernelPackages = pkgs.linuxPackages_zen;

		# Allow the installation process to modify EFI boot variables.
		loader.efi.canTouchEfiVariables = lib.mkIf config.boot.loader.limine.enable true;
	};

	# Program that allows manually modifying the EFI boot manager and its entries.
	environment.systemPackages = [ pkgs.efibootmgr ];

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "R5-PC";

	# Disable NetworkManager's `ModemManager` service to improve boot times.
	# Only disable if not using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = lib.mkIf config.networking.networkmanager.enable false;

	# Whether to enable the FWup firmware update manager.
	services.fwupd.enable = true;
}