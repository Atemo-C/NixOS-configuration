{ config, lib, pkgs, ... }: {
	# Whether to enable support for the Android Debug Bridge.
	programs.adb.enable = true;

	# Add the user to the `adbusers` group for ADB usage.
	users.users.${config.userName}.extraGroups = lib.optional config.programs.adb.enable "adbusers";

	environment.systemPackages = with pkgs; [
		# Implementation of Microsoft's Media Transfer Protocol (MTP).
		libmtp

		# FUSE filesystem for MTP devices.
		jmtpfs
	] ++ lib.optionals config.programs.adb.enable (with pkgs; [
		# Reverse tethering over ADB.
		gnirehtet

		# Tool suite used to flash firmware onto Samsung Galaxy devices.
		heimdall

		# Display and control Android devices over USB or TCP/IP.
	]) ++ lib.optional (config.programs.adb.enable && config.programs.niri.enable) pkgs.scrcpy;
}