{ config, ... }: {

	# Whether to enable periodic SSD TRIMof mounted partitions in the background.
	# May not be necessary on filesystems that do it automatically.
	# https://search.nixos.org/options?channel=24.05&show=services.fstrim.enable
	services.fstrim.enable = true;

}
