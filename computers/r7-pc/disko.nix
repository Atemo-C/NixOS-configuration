{ disko.devices.disk.main = {
	type = "disk";

	# Device to format and partition.
	# Prefer a stable identifier when possible, instead of something like `/dev/sda`.
	device = "/dev/disk/by-id/nvme-CT2000P510SSD5_2522E9C132DC";

	content = {
		# Partition table.
		type = "gpt";

		# Partition layout.
		partitions = {
			# 2 MB partition for legacy BIOS-only systems.
			bios = {
				size = "2M";
				type = "EF02";
			};

			# 1GB fat32 boot/ESP partition.
			esp = {
				size = "1G";
				type = "EF00";
				content = {
					type = "filesystem";
					format = "vfat";
					mountpoint = "/boot";
					mountOptions = [ "umask=077" ];
				};
			};

			# 8 GB encrypted swap volume.
			swap = {
				size = "8G";
				content = {
					type = "luks";
					name = "swap";
					settings = {
						# Whether to enable discard; Enable on SSDs only.
						allowDiscards = true;

						#USB flash drive as encryption key, with manual password fallback.
						# If you use one, keep it very well-hidden, and only use it when safe to.
						keyFileSize = 4096;
						keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
						keyFileTimeout = 10;
					};

					# Define the type as swap and enable hibernation support.
					content = {
						type = "swap";
						resumeDevice = true;
					};
				};
			};

			# Encrypted Btrfs volume taking the remaining storage space.
			root = {
				size = "100%";

				content = {
					type = "luks";
					name = "storage";

					settings = {
						# Whether to enable discard; Enable on SSDs only.
						allowDiscards = true;

						# USB flash drive as encryption key, with manual password fallback.
						# If you use one, keep it very well-hidden, and only use it when safe to.
						keyFileSize = 4096;
						keyFile = "/dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0";
						keyFileTimeout = 10;
					};

					# Define the type as btrfs storage.
					# ZSTD compression is used everywhere;
					# `noatime` is added for the @nix subvolume as well.
					content = {
						type = "btrfs";
						extraArgs = [ "-f" ];
						subvolumes = {
							"@" = {
								mountpoint = "/";
								mountOptions = [ "compress=zstd:3" ];
							};

							"@home" = {
								mountpoint = "/home";
								mountOptions = [ "compress=zstd:3" ];
							};

							"@nix" = {
								mountpoint = "/nix";
								mountOptions = [ "compress=zstd:3" "noatime" ];
							};
						};
					};
				};
			};
		};
	};
}; }

# Additional device encryption settings.
# All commands here must be run as root.
#
# Here is how to create a dedicated USB flash drive for
# unlocking your LUKS-encrypted system (secure it away!):
# 1. Generate a random key with `dd`, like so:
#    • dd if=/dev/random of=disk-key.key bs=4096 count=1
#
# 2. Add the key to your encrypted storage partition(s) that use the same password:
#    • cryptsetup luksAddKey /dev/your-encrypted-partition-here ./disk-key.key
#    (repeat if you have multiple encrypted partitions)
#
# 3. Write the key file to the USB flash drive (ALL data on it will be erased):
#    • dd if=disk-key.key of=/dev/your-usb-flash-drive-here
#
# 4. Add the relevant options to all of your relevant LUKS-encrypted partitions,
#    as seen either above or in other disko modules within this configuration.