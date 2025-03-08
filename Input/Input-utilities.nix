{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# Show mouse refresh rate under linux + evdev.
	evhz

	# Utility for mapping events from Linux event devices.
	evsieve

	# A simple GTK-based joystic tester.
	jstest-gtk

	# User-mode driver and GUI for any controller.
	sc-controller

	# Toolsf or working with USB devices, such as lsusb.
	usbutils

	# Fast GUI autoclicker for x11/xwayland programs.
	xclicker

]; }
