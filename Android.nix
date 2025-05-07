{ config, pkgs, ... }: let adb = config.programs.adb.enable; in {

	# Whether to enable support for the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# If ADB is enabled, the user is added to the `adbusers` group.
	users.users.${config.userName}.extraGroups = if adb then [ "adbusers" ] else [];

	# Install some Andorid-related utilities.
	environment.systemPackages = [
		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# FUSE filesystem for MTP devices.
		pkgs.jmtpfs
	] ++ (
		# The following utilities depend on ADB.
		if adb then [
			# Reverse tethering over ADB for Android.
			pkgs.gnirehtet

			# Display & control Android devices over USB or TCP/IP.
			pkgs.scrcpy
		] else []
	);

}
