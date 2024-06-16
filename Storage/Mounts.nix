{ config, ... }: {

	fileSystems."/path/to/mount" = {
		device = "/dev/disk/by-uuid/drive-uuid";
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
