{ config, ... }: {

	# Mount for the 480GB internal SATA SSD.
#	fileSystems."/run/media/${config.custom.name}/480GB-SSD-INT" = {
#		device = "/dev/disk/by-label/480GB-SSD-INT";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

	# Mount for the 500GB internal SATA HDD.
#	fileSystems."/run/media/${config.custom.name}/500GB-HDD-INT" = {
#		device = "/dev/disk/by-label/500GB-HDD-INT";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

	# Mount for the 1TB internal SATA HDD.
#	fileSystems."/run/media/${config.custom.name}/1TB-HDD-INT" = {
#		device = "/dev/disk/by-label/1TB-HDD-INT";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

	# Mount for the 1TB external SATA HDD.
#	fileSystems."/run/media/${config.custom.name}/1TB-HDD-EXT" = {
#		device = "/dev/disk/by-label/1TB-HDD-EXT";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

	# Mount for the 160GB internal SATA HDD.
#	fileSystems."/run/media/${config.custom.name}/150GB-HDD-5400RPM-INT" = {
#		device = "/dev/disk/by-label/150GB-HDD-5400RPM-INT";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

}
