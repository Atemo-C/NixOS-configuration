{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# Show mouse refresh rate.
		evhz

		# Utility for mapping events from Linux event devices.
		# e.g. `sudo evsieve --input /dev/input/by-id/… --map btn:extra key:f13 --output`
		evsieve

		# Graphical joystic tester.
		jstest-gtk

		# User-mode driver and GUI for configuring any controller.
		# Note: Awesome, but way too buggy for me.
		#sc-controller

		# Tools for working with USB devices, such as `lsusb`.
		usbutils

		# Autoclicker for XWayland programs.
		xclicker
	]);
}