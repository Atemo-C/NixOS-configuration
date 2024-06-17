{ config, ... }: {

	# Whether to enable the Andriod Debug Bridge.
	# https://search.nixos.org/options?channel=24.05&show=programs.adb.enable
	programs.adb.enable = true;

	users.users.username.extraGroups = [ "adbusers" ];

}
