{ config, pkgs, ... }: let ADB = config.programs.adb.enable; in {

	# Whether to enable support for the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Add the user to the `adbusers` group if ADB is enabled.
	users.users.${config.userName}.extraGroups = if ADB then [ "adbusers" ] else [];

	# Android-related utilities.
	environment.systemPackages = [
		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# FUSE filesystem for MTP devices like Android ones.
		pkgs.jmtpfs
	] ++ (
		# Only install these utilities if ADB is enabled.
		if ADB then [
			# Reverse tethering over ADB for Android.
			pkgs.gnirehtet

			# Display and control Android devices over USB or TCP/IP.
			pkgs.scrcpy
		] else []
	);

}
