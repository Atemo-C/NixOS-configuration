{ config, ... }: {

	# Mount for 1TB Toshiba DT01ACA100 7200RPM HDD.
#	fileSystems."/run/media/${config.userName}/1TB-GPT-TOSHIBA" = {
#		device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_448164BNS-part1";
#		fsType = "btrfs";
#		options = [
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		];
#	};

	# Mount for the 500GB HGST HTS545050A7E680 5400RPM HDD (PS4).
#	fileSystems."/run/media/${config.userName}/5GhB-GPT-HGST" = {
#		device = "/dev/disk/by-id/ata-HGST_HTS545050A7E680_160607RBF54AAH3E8DNP-part1";
#		fsType = "btrfs";
#		options = {
#			"defaults"
#			"rw"
#			"nofail"
#			"users"
#			"exec"
#		};
#	};

}
