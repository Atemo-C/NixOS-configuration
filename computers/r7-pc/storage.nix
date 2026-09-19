{ ... }: {
	# Additional device encryption settings.
	#
	# Here is how to create a dedicated USB flash drive for
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
	boot.initrd.luks.devices = {
		"2tb-swap" = {
			# Add the swap LUKS device, as `nixos-generate-config` does not.
			device = "/dev/disk/by-uuid/2f1d31cb-8168-43ab-aa78-3e421e0fb89b";

			# If on an SSD with discard support, enable it.
			allowDiscards = true;

			# Hardware key encryption keys, with manual password fallback.
			keyFileSize = 4096;
			keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
			keyFileTimeout = 10;
		};

		"2tb-root" = {
			# If on an SSD with discard support, enable it.
			allowDiscards = true;

			# Hardware key encryption keys, with manual password fallback.
			keyFileSize = 4096;
			keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
			keyFileTimeout = 10;
		};
	};

	fileSystems = {
		# ZSTD compression for the root (@) subvolume.
		"/".options = [ "compress=zstd:3" ];

		# ZSTD compression for the @home subvolume.
		"/home".options = [ "compress=zstd:3" ];

		# ZSTD compression + no-access-time for the @nix subvolume.
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	# Other storage devices used in this computer.
	imports = [
		# PlayStation 4 HDD, used to store ISOs, OBS recordings, and more.
		./drives/PS4-HDD.nix

		# ThinkPad L510 HDD, used to store home backups.
		./drives/160GB-HDD.nix
	];
}