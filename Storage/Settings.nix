# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Btrfs
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=services.btrfs.autoScrub.enable
# • https://search.nixos.org/options?channel=24.11&show=services.fstrim.enable

{ config, ... }: { services = {

	# Whether to enable regular btrfs scrub.
	btrfs.autoScrub.enable = true;

	# Whether to enable periodic SSD TRIM of mounted partitions in background.
	# May not be necessary on filesystems with a similar function enabled.
	fstrim.enable = false;

}; }
