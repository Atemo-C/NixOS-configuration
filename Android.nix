{ config, pkgs, ... }: rec {

	# Whether to configure system to use Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# If ADB is enabled, add the user to the `adbusers` group.
	users.users.${config.userName}.extraGroups = (if programs.adb.enable then [ "adbusers" ] else null);

	# Android-related packages.
	environment.systemPackages = [
		# Reverse tethering over ADB for Android.
		(if programs.adb.enable then pkgs.gnirehtet else null)

		# Display and control Android devices over USB or TCP/IP.
		(if programs.adb.enable then pkgs.scrcpy else null)

		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# FUSE filesystem for MTP devices like Android devices.
		pkgs.jmtpfs
	];

}
