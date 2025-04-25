{ config, ... }: {

	# Mount for the 480GB internal SATA SSD.
#	fileSystems."/run/media/${config.userName}/480GB-SSD-INT" = {
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
#	fileSystems."/run/media/${config.userName}/500GB-HDD-INT" = {
#		device = "/dev/disk/by-id/ata-ST3500418AS_5VMETGG9";
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
#	fileSystems."/run/media/${config.userName}/1TB-HDD-INT" = {
#		device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_448164BNS";
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
#	fileSystems."/run/media/${config.userName}/1TB-HDD-EXT" = {
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
#	fileSystems."/run/media/${config.userName}/150GB-HDD-5400RPM-INT" = {
#		device = "/dev/disk/by-id/ata-WDC_WD1600BEVS-08VAT2_WD-WXP1A30R8683";
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
