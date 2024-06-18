{ config, ... }: {

	# Whether to enable the Andriod Debug Bridge.
	# https://search.nixos.org/options?channel=24.05&show=programs.adb.enable
	programs.adb.enable = true;

	# User's auxilary group for accessing the Android Debug Bridge.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.${config.Custom.Name}.extraGroups = [ "adbusers" ];

}
