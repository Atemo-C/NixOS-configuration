{ config, lib, pkgs, ... }: {
	# Select the Linux Kernel version to use.
	# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Program that allows manually modifying the EFI boot manager and its entries.
	environment.systemPackages = [ pkgs.efibootmgr ];

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "HP-250-G6";

	# Disable the ModemManager service to improve boot times.
	# Only disable if not using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;

	services = {
		# Whether to enable the FWup firmware update manager.
		fwupd.enable = true;

		# Whether to enable preload.
		preload.enable = true;

		# Keyboard layout to use (priority over `./input/keyboard-layout.nix`).
		xserver.xkb.layout = lib.mkForce "fr";
		xserver.xkb.variant = lib.mkForce "";
	};

	# zram swap (memory compresssion); 4GB of RAM is not enough for tasks like web browsing or…updating. Yikes.
	zramSwap = {
		# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Maximum total amount of memory that can be stored in the zram swap devices.
		# Run `zramctl` to check how much memory is compressed.
		memoryPercent = 50;

		# Priority of the zram swap device.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling bcak to disk swap.
		priority = 50;
	};
}