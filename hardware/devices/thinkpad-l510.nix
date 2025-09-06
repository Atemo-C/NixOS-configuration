{ config, lib, pkgs, ... }: {
	# Select the Linux Kernel version to use.
	# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Set the drive to install Limine onto.
	# You can see its name by running `ls /dev/disk/by-id`.
	boot.loader.limine.biosDevice = "/dev/disk/by-id/disk-stuff-here";

	# Disable support for EFI booting.
	boot.loader.limine.efiSupport = false;

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "ThinkPad-L510";

	# Disable the ModemManager service to improve boot times.
	# Only disable if not using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;

	# Service that overrides the default suspend command.
	# This is because the default `systemctl suspend` command does not work onthis laptop.
	systemd.services."systemd-suspend" = lib.mkIf (lib.elem pkgs.pmutils config.environment.systemPackages) {
		description               = "System suspend with pm-suspend";
		serviceConfig.Type        = "oneshot";
		serviceConfig.Environment = "PATH=${pkgs.pmutils}/bin";
		serviceConfig.ExecStart   = "" "${pkgs.pmutils}/bin/pm-suspend";
	};

	# Small collection of scripts that handle suspend and resume on behalf of HAL.
	# The script above will only be enabled if it is installed.
	environment.systemPackages = [ pkgs.pmutils ];

	# Keyboard layout to use (priority over `./input/keyboard-layout.nix`).
	services.xserver.xkb.layout = lib.mkForce "fr";
	services.xserver.xkb.variant = lib.mkForce "";

	# zram swap (memory compresssion); 2GB of RAM is NOT enough for tasks like web browsing or updating the system.
	zramSwap = {
		# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Maximum total amount of memory that can be stored in the zram swap devices.
		# Run `zramctl` to check how much memory is compressed.
		memoryPercent = 100;

		# Priority of the zram swap device.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling bcak to disk swap.
		priority = 50;
	};
}