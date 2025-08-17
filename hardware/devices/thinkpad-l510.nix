{ config, lib, pkgs, ... }: {
	boot = {
		# Select the Linux Kernel version to use.
		# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
		kernelPackages = pkgs.linuxPackages_latest;

		loader.limine = {
			# Set the drive to install Limine onto.
			# You can see its nam eby running `ls /dev/disk/by-id`.
			biosDevice = lib.mkIf config.boot.loader.limine.enable "/dev/disk/by-id/disk-stuff-here";

			# Disable support for EFI booting.
			efiSupport = lib.mkIf config.boot.loader.limine.enable false;
		};
	};

	# Name of the system over the network.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "ThinkPad-L510";

	systemd.services = {
		# Disable NetworkManager's `ModemManager` service to improve boot times.
		# Only disable if not using cellular data (tethering from a mobile device does not count).
		ModemManager.enable = lib.mkIf config.networking.networkmanager.enable false;

		# Service that overrides the default suspend command.
		# This is because the default `systemctl suspend` does not work on this laptop.
		"systemd-suspend" = lib.mkIf lib.elem pkgs.pmutils config.environment.systemPackages {
			description = "System suspend with pm-suspend";
			serviceConfig = {
				Type = "oneshot";
				Environment = "PATH=${pkgs.pmutils}/bin";
				ExecStart = [
					""
					"${pkgs.pmutils}/bin/pm-suspend"
				];
			};
		};
	};

	# Small collection of scripts that handle suspend and resume on behalf of HAL.
	# The script above will only be enabled if it is installed.
	environment.systemPackages = [ pkgs.pmutils ];

	# Keyboard layout to use (priority over `./input/keybord-layout.nix`).
	services.xserver.xkb = {
		layout = lib.mkForce "fr";
		variant = lib.mkForce "";
	};

	# zram, because 2GB of RAM is not enough for tasks like web browsing or updating the system.
	zramSwap = rec {
		# Whether to enable in-memory compression devices and swap space provided by the zram kernel module.
		enable = true;

		# Compression algorithm to use.
		# `842`, `lzo`, `lzo-rle`, `lz4`, `lz4hc`, `zstd`, or other.
		algorithm = lib.mkIf enable "zstd";

		# Maximum total amount of memory that can be stored in the zram swap devices.
		# Run `zramctl` to check how good memory is compressed.
		memoryPercent = lib.mkIf enable 85;

		# Priority of the zram swap device.
		# It should be a number higher than the priority of your disk-based swap devices,
		# so that the system will fill the zram swap device before falling bcak to disk swap.
		priority = lib.mkIf enable 50;
	};

}