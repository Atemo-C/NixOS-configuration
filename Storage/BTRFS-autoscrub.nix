{ config, ... }: {

	# Whether to enable regular BTRFS scrub.
	# https://search.nixos.org/options?channel=24.05&show=services.btrfs.autoScrub.enable
	services.btrfs.autoScrub.enable = true;

}
