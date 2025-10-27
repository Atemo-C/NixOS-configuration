{ config, lib, ... }: { programs = {
	# Reverse tethering over ADB for Android.
	gnirehtet.enable = true;

	# Tool suite used to flash firmware onto Samsung Galaxy devices.
	heimdall.enable = true;

	# FUSE filesystem for MTP devices like Android phones.
	jmtpfs.enable = true;

	# Implementation of Microsoft's Media Transfer Protocol.
	libmtp.enable = true;

	# Display and control Android devices over USB or TCP/IP.
	scrcpy.enable = lib.mkIf config.programs.niri.enable true;

	# Shortcut to fix audio playback crashing certain LineageOS-based Android distributions.
	fish.shellAbbrs.fix-los-audio = lib.mkIf (
		config.programs.fish.enable
		&& config.programs.adb.enable
	)
	"adb shell device_config put media_solutions com.android.settingslib.media.flags.use_media_router2_for_info_media_manager false && adb reboot";
}; }