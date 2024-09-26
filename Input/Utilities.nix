# Used NixOS packages:
#─────────────────────
# • [evsieve]
#   https://github.com/KarsMulder/evsieve
#
# • [usbutils]
#   http://www.linux-usb.org/

{ pkgs, ... }: { environment.systemPackages = [

	# A utility for mapping events from Linux event devices.
	pkgs.evsieve

	# Tools for working with USB devices, such as lsusb.
	pkgs.usbutils

]; }
