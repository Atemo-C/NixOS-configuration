{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Reverse tethering over ADB for Android.
		gnirehtet

		# Implementation of Microsoft's Media Transfer Protocol.
		libmtp

		# Display and control Android devices over USB or TCP/IP
		scrcpy
	];

	# Whether to enable the use of the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Adds the current user to the ADB users group.
	users.users.${config.custom.name}.extraGroups = [ "adbusers" ];

}
