# Note: Unfortunately, EFI detection with `pkgs.stdenv.hostPlatform.isEfi` is broken on quite a few systems.
# If on a BIOS-only system, you have to set the `efiSupport` of the Limine bootloader to `false` here.

{ config, lib, pkgs, ... }: let

	# EFI support; See comment at the top of the module; Toggleable in this module.
	efi = config.boot.loader.limine.efiSupport;

in {

	boot = {
		loader = {
			limine = {
				# Whether to enable the Limine bootloader.
				enable = true;

				# If booting in BIOS mode, select the drive to install Limine onto.
				# You can see its name by running the command `ls /dev/disk/by-id`.
				biosDevice = if efi then "nodev" else "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0W519865N";

				# Whether to install the limine EFI files.
				efiSupport = true;

				# Maximum number of latest NixOS generations to keep in the boot menu.
				# This prevents the boot partition from running out of disk space.
				maxGenerations = 32;
			};

			# Timeout, in seconds, until the first entry in the bootloader is activated.
			timeout = 1;

			# If in EFi mode, allow the installation process to modify EFI boot variables.
			efi.canTouchEfiVariables = efi;
		};

		# Optionally, reduce logging when booting with the following settings.
		kernelParams = [
			"quiet"
			"loglevel=3"
			"udev.log_priority=3"
			"rd.udev.log_level=3"
			"rd.systemd.show_status=auto"
		];
		consoleLogLevel = 3;
		initrd.verbose = false;
	};

	# If in EFI mode, install a utility to manually modify the EFI boot manager and its entries.
	environment.systemPackages = lib.optionalAttrs efi [ pkgs.efibootmgr ];

}
