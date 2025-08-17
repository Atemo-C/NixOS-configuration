{ config, lib, pkgs, ... }: {
	boot = {
		# Select the Linux Kernel version to use.
		# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
		kernelPackages = pkgs.linuxPackages_latest;

		# Allow the installation process to modify EFI boot variables.
		loader.efi.canTouchEfiVariables = lib.mkIf config.boot.loader.limine.enable false;
	};

	# Program that allows manually modifying the EFI boot manager and its entries.
	environment.systemPackages = [ pkgs.efibootmgr ];

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "HP-250-G6";

	# Disable NetworkManager's `ModemManager` service to improve boot times.
	# Only disable if not using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = lib.mkIf config.networking.networkmanager.enable false;

	services = {
		# Whether to enable the FWup firmware update manager.
		fwupd.enable = true;

		# Whether to enable preload.
		preload.enable = true;

		# Keyboard layout to use (priority over `./input/keyboard-layout.nix`).
		xserver.xkb = {
			layout = lib.mkForce "fr";
			variant = lib.mkForce "";
		};
	};

	# zram, because 4GB of RAM is not enough for tasks like web browsing or updating the system.
	zramSwap = rec {
		# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Compression algorithm to use.
		# `842`, `lzo`, `lzo-rle`, `lz4`, `lz4hc`, `zstd`, or other.
		algorithm = lib.mkIf enable "zstd";

		# Maximum total amount of memory that can be stored in the zram swap devices.
		# Run `zramctl` to check how good memory is compressed.
		memoryPercent = lib.mkIf enable 70;

		# Priority of the zram swap device.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling bcak to disk swap.
		priority = lib.mkIf enable 50;
	};
}
