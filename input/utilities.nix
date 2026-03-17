{ config, lib, pkgs, ... }: rec {
	environment.systemPackages = with pkgs; [
		# Show mouse refresh rate under Linux + evdev.
		evhz

		# Utility for mapping events from Linux event devices.
		evsieve

		# Simple joystick tester based on Gtk+.
		jstest-gtk

		# RGB editor for the MiDiPlus SmartPAD.
		(pkgs.callPackage ../extra-modules/atemo_cajaku/packages/midiplussmartpadrgbeditor/package.nix)

		# User-mode driver and GUI for game controllers.
		sc-controller

		# Console-based typing speed test and practice.
		typioca

		# Tools for working with USB devices, such as `lsusb`.
		usbutils
	];

	# Whether to enable ydotool, a generic Linux command-line automation tool.
	programs.ydotool.enable = true;

	# Add the user to the `ydotool` group.
	users.users.${config.user.name}.extraGroups = lib.optional programs.ydotool.enable "ydotool";
}