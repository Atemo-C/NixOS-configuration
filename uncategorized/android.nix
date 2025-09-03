{ config, lib, pkgs, ... }: {
	# Whether to enable support for the Android Debug Bridge.
	programs.adb.enable = true;

	# Add the user to the `adbusers` group for ADB usage.
	users.users.${config.userName}.extraGroups = lib.optional config.programs.adb.enable "adbusers";

	environment.systemPackages = with pkgs; [
		libmtp # Implementation of Microsoft's Media Transfer Protocol (MTP).
		jmtpfs # FUSE filesystem for MTP devices.

	] ++ lib.optionals config.programs.adb.enable (with pkgs; [
		gnirehtet # Reverse tethering over ADB.
		heimdall  # Tool suite used to flash firmware onto Samsung Galaxy devices.

		# Display and control Android devices over USB or TCP/IP.
	]) ++ lib.optional (config.programs.adb.enable && config.programs.niri.enable) pkgs.scrcpy;
}