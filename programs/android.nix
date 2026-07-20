{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Android SDK platform tools.
		android-tools

		# Reverse tethering over ADB for Android.
		gnirehtet

		# Tool suite used to flash firmware onto Samsung Galaxy devices.
		heimdall

		# FUSE filesystem for MTP devices like Android phones.
		# (Now no longer maintained.)
#		jmtpfs

		# Implementation of Microsoft's Media Transfer Protocol.
		libmtp

		# Display and control Android devices over USB or TCP/IP.
		scrcpy
	];

	# Add the user to the `adbusers` group;
	# Necessary for many of these programs to fully work.
	users.users.${config.user.name}.extraGroups = [ "adbusers" ];
}