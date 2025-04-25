{ config, pkgs, ... }: rec {

	# Whether to allow the use of the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# If ADB is enabled, add the user to the `adbusers` group.
	users.users.${userName}.extraGroups = ( if programs.adb.enable then [ "adbusers" ] else null );

	# Various Android packages and utilities.
	# Some packages will only install if ADB is enabled.
	environment.systemPackages = [
		# Reverse tethering over ADB.
		( if programs.adb.enable then pkgs.gnirehtet else null )

		# Display and control Android devices over USB or TCP/IP.
		( if programs.adb.enable then pkgs.scrcpy else null )

		# Implementation of Microsoft's Media Transfer Protocol.
		pkgs.libmtp

		# FUSE filesystem for MTP devices like Android devices.
		pkgs.jmtpfs
	];

}
