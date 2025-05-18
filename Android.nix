{ config, lib, pkgs, ... }: let

	# Android Debug Bridge (ADB) support; Toggleable in this module.
	adb = config.programs.adb.enable;

in {

	# Whether to enbale support for the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Add the user to the `adbusers` group.
	users.users.${config.userName}.extraGroups = lib.optionalAttrs adb [ "adbusers" ];

	# Install some Android-related packages.
	environment.systemPackages = [
		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# FUSE filesystem for MTP devices.
		pkgs.jmtpfs
	] ++ (lib.optionalAttrs adb [
		# Reverse tethering over ADB for Android.
		pkgs.gnirehtet

		# Display & control Android devices over USB or TCP/IP.
		pkgs.scrcpy
	] );

}
