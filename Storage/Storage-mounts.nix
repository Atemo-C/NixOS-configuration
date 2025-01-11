{ config, ... }: {

	# Mount for the 480GB internal SATA SSD.
#	fileSystems."/run/media/user-name/480GB-SSD-INT" = {
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
#	fileSystems."/run/media/user-name/500GB-HDD-INT" = {
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
	fileSystems."/run/media/user-name/1TB-HDD-INT" = {
		device = "/dev/disk/by-label/1TB-HDD-INT";
		fsType = "btrfs";
		options = [
			"defaults"
			"rw"
			"nofail"
			"users"
			"exec"
		];
	};

}
