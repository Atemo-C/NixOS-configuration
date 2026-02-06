{ config, lib, ... }: { programs = {
	# Android SDK platform tools.
	android-tools.install = true;

	# Reverse tethering over ADB for Android.
	gnirehtet.enable = true;

	# Cross-platform open-source tool suite used to flash firmware onto Samsung Galaxy devices.
	heimdall.enable = true;

	# FUSE filesystem for MTP devices like Android phones.
	jmtpfs.install = true;

	# Implementation of Microsoft's Media Transfer Protocol.
	libmtp.install = true;

	# Display and control Android devices over USB or TCP/IP.
	scrcpy.enable = true;
}; }