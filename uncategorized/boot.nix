# If booting in BIOS mode instead, you need to add two options.
# For this, modify your device's `settings.nix` module:
# • Set `boot.loader.limine.biosDevice` to the storage device where Limine is installed (e.g. `/dev/sda`).
# • Set `boot.loader.limine.efiSupport` to `false`.
# Additionally, you may want to overwride the Linux kernel version used if it does not work on your hardware.
{ config, lib, pkgs, ... }: let efiSupport = config.boot.loader.limine.efiSupport; in {
	boot = {
		# Runtime parameters of the Linux Kernel to enhance performances in certain areas (like gaming),
		# and to help future-proof.
		kernel.sysctl = {
			"kernel.sched_cfs_bandwidth_slice_us" = 3000;
			"net.ipv4.tcp_fin_timeout" = 5;
			"vm.max_map_count" = 2147483642;
		};

		# Select the Linux Kernel version to use.
		# https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels
		kernelPackages = pkgs.linuxPackages_zen;

		# Additional kernel parameters to help performances in certain areas.
		kernelParams = [ "preempt=full" ];

		loader = {
			limine = {
				# Whether to enable the Limine bootloader.
				# Note that when using Limine as the bootloader, `systemctl kexec` will not work out of the box.
				enable = true;

				# Maximum number of latest generations in the boot menu.
				# Lowering this value can help prevent the boot partition from running out of disk space.
				maxGenerations = 16;
			};

			# Timeout in seconds until the first entry in the bootloader is activated.
			# Use `null` if the menu should be displayed until the user manually selects an entry.
			timeout = 1;
		};
	};

	# Whether to install efibootmgr, a program that allows manually modifying the EFI boot manager and its entries.
	programs.efibootmgr.install = lib.mkIf efiSupport true;
}