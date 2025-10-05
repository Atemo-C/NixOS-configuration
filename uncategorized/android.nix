{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		libmtp # Implementation of Microsoft's Media Transfer Protocol (MTP).
		jmtpfs # FUSE filesystem for MTP devices.
	];

	programs = {
		# Whether to enable gnirehtet, a program allowing reverse tethering over ADB.
		gnirehtet.enable = true;

		# Whether to enable heimdall, a tool suite used to flash firmware onto Samsung Galaxy devices.
		heimdall.enable = true;

		# Whether to enable scrcpy, a program to display and control Android devices over USB or TCP/IP.
		scrcpy.enable = lib.mkIf config.programs.niri.enable true;

		# Shortcut to fix audio playback crashign the phone on LineageOS-based Android distributions.
		fish.shellAbbrs.fix-los-audio = lib.mkIf (config.programs.adb.enable && config.programs.adb.enable)
		"adb shell device_config put media_solutions com.android.settingslib.media.flags.use_media_router2_for_info_media_manager false && adb reboot";
	};
}