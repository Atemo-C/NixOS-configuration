# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Smartmontools
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=unstable&show=services.smartd.enable
# • https://search.nixos.org/options?channel=unstable&show=services.udisks2.enable

{ config, ... }: { services = {

	# Whether to enable smartd daemon from smartmontools package.
	smartd.enable = true;

	# Whether to enable udisks2, a DBus service that allows applications to query and manipulate storage devices.
	udisks2.enable = true;

}; }
