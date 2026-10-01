{ disko.devices.disk.main = {
	type = "disk";

	# Device to format and partition.
	# Prefer a stable identifier when possible, instead of something like `/dev/sda`.
	device = "/dev/disk/by-id/ata-TOSHIBA_MQ04ABF100_Y867P710T";

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

					# Whether to enable discard; Enable on SSDs only.
					settings.allowDiscards = false;

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

					# Whether to enable discard; Enable on SSDs only.
					settings.allowDiscards = false;

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