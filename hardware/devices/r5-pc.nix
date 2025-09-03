{ config, lib, pkgs, ... }: {
	# Select the Linux Kernel version to use.
	# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Program that allows manually modifying the EFI boot manager and its entries.
	environment.systemPackages = [ pkgs.efibootmgr ];

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "R5-PC";

	# Disable the ModemManager service to improve boot times.
	# Only disable if not using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;

	services = {
		# Whether to enable the FWup firmware update manager.
		fwupd.enable = true;

		# Whether to enable LACT, a tool for monitoring, configuring, and overclocking GPUs.
		lact.enable = true;

		# Whether to enable preload.
		preload.enable = true;
	};

	# zram swap (memory compresssion); Just in case..
	zramSwap = {
		# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Maximum total amount of memory that can be stored in the zram swap devices.
		# Run `zramctl` to check how much memory is compressed.
		memoryPercent = 20;

		# Priority of the zram swap device.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling bcak to disk swap.
		priority = 50;
	};
}