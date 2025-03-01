{ pkgs, ... }: { environment.systemPackages = [

	# Show mouse refresh rate under linux + evdev.
	pkgs.evhz

	# Utility for mapping events from Linux event devices.
	pkgs.evsieve

	# A simple GTK-based joystic tester.
	pkgs.jstest-gtk

	# User-mode driver and GUI for any controller.
	pkgs.unstable.sc-controller

	# Toolsf or working with USB devices, such as lsusb.
	pkgs.usbutils

	# Fast GUI autoclicker for x11/xwayland programs.
	pkgs.xclicker

]; }
