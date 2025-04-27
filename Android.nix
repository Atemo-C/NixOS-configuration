{ config, pkgs, ... }: rec {

	# Enable support for the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Add the user to the `adbusers` group if ADB is enabled.
	users.users.${config.userName}.extraGroups = (if programs.adb.enable then [ "adbusers" ] else null);

	# Android-related utilities.
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
