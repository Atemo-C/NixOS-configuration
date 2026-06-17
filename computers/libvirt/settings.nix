{ config, lib, pkgs, ... }: {
	boot = {
		initrd = {
			# Enable USB storage support during the boot process.
			kernelModules = [ "usb_storage" ];

			# Additional device encryption settings.
			#
			# [Tip] Here is how to create a dedicated USB flash drive for
			# unlocking your LUKS-encrypted system (secure it away!):
			# 1. Generate a random key with `dd`, like so:
			#    • dd if=/dev/random of=disk-key.key bs=4096 count=1
			#
			# 2. Add the key to your encrypted storage partition(s) that use the same password:
			#    • run0 cryptsetup luksAddKey /dev/your-encrypted-partition-here ./disk-key.key
			#    (repeat if you have multiple encrypted partitions)
			#
			# 3. Write the key file to the USB flash drive (ALL data on it will be erased):
			#    • run0 dd if=disk-key.key of=/dev/your-usb-flash-drive-here
			luks.devices = {
				swap = {
					# Add the swap LUKS device, as `nixos-generate-config` does not.
					device = "/dev/disk/by-uuid/5384a495-fcd5-4791-9b19-620b954a1156";

					# If on an SSD with discard support, enable it.
					allowDiscards = true;

					# Hardware key encryption keys, with manual password fallback.
					keyFileSize = 4096;
					keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
					keyFileTimeout = 10;
				};

				root = {
					# If on an SSD with discard support, enable it.
					allowDiscards = true;

					# Hardware key encryption keys, with manual password fallback.
					keyFileSize = 4096;
					keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
					keyFileTimeout = 10;
				};
			};
		};

		# Whether the installation process is allowed to modify EFI boot variables.
		# Once installed and working, if after an update, it fails to "install" again,
		# it should be safe to turn this option off, even if not ideal.
		loader.efi.canTouchEfiVariables = true;
	};

	# ZSTD compression and no-access-time configuration for the main volumes.
	fileSystems = {
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	# Name of the computer over the network.
	networking.hostName = "libvirt";

	systemd = {
		# Whether to enable Modem Manager, to handle cellular data.
		services.ModemManager.enable = false;

		# User service to properly start the spice vdagent.
		user.services.spice-vdagent = lib.mkIf config.services.spice-vdagentd.enable {
			description = "spice-vdagent user daemon";
			after = [ "spice-vdagentd.service" "graphical-session.target" ];
			requires = [ "graphical-session.target" ];
			wantedBy = [ "graphical-session.target" ];
			serviceConfig.ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
			unitConfig.ConditionPathExists = "/run/spice-vdagentd/spice-vdagent-sock";
		};
	};

	services = {
		# Whether to enable the spice-vdagentd daemon.
		spice-vdagentd.enable = true;

		# Whether to enable QEMU guest additions.
		qemuGuest.enable = true;

		# Keyboard layout configuration on this system.
		# To see a complete list of layouts, variants, and other settings:
		# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
		#
		# To see why this list cannot easily be seen within NixOS:
		# • https://github.com/NixOS/nixpkgs/issues/254523
		# • https://github.com/NixOS/nixpkgs/issues/286283
		xserver.xkb = {
			layout = "us,fr";
			variant = "intl,";
		};
	};

	imports = [
		# Utility to convert a MiDiPLUS SmartPAD into a full macro pad.
		../../extra-modules/scripts/midiplus-smartpad-macropad.nix
	];
}
