# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Filesystems

{ config, ... }: {

	# Mount for an internal 1TB SATA SSD.
	fileSystems."/run/media/your-name/1TB-SSD-INT" = {
		device = "/dev/disk/by-label/1TB-SSD-INT";
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
