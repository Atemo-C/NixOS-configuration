{ config, pkgs, ... }: {

	environment.systemPackages = [
		# Reverse tethering over ADB for Android.
		pkgs.gnirehtet

		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# Display and control Android devices over USB or TCP/IP
		pkgs.unstable.scrcpy
	];

	# Whether to enable the use of the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Adds the current user to the ADB users group.
	users.users.${config.custom.name}.extraGroups = [ "adbusers" ];

}
