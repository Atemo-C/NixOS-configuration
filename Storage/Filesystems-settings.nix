{ config, ... }: { services = {

	# Whether to enable periodic scrubbing on BTRFS.
	btrfs.autoScrub.enable = true;

	# Whether to enable periodic SSD TRIM.
	# May not be necessarry on filesystems with a similar function enabled.
	fstrim.enable = false;

}; }
