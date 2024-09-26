# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Android
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=programs.adb.enable
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.extraGroups

{ config, ... }: {

	# Whether to configure system to use Android Debug Bridge (adb).
	programs.adb.enable = true;

	# Add the user to these auxiliary groups.
	users.users.${config.custom.name}.extraGroups = [ "adbusers" "kvm" ];

}
