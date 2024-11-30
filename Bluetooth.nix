# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Bluetooth
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=hardware.bluetooth.enable
# • https://search.nixos.org/options?channel=24.11&show=services.blueman.enable
#
# Used packages:
#───────────────
# • [blueberry]
#   https://github.com/linuxmint/blueberry

{ config, pkgs, ... }: {

	# Bluetooth configuration tool.
	environment.systemPackages = [ pkgs.blueberry ];

	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# Whether to enable blueman, a bluetooth mannager.
	services.blueman.enable = true;

}
