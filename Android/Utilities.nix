# Used packages:
#───────────────
# • [gnirehtet]
#   https://github.com/Genymobile/gnirehtet
#
# • [libmtp]
#   https://github.com/libmtp/libmtp
#
# • [scrcpy]
#   https://github.com/Genymobile/scrcpy

{ pkgs, ... }: { environment.systemPackages = [

	pkgs.gnirehtet # Reverse tethering over adb for Android.
	pkgs.libmtp    # An implementation of Microsoft's Media Transfer Protocol.
	pkgs.scrcpy    # Display and control Android devices over USB or TCP/IP.

]; }
