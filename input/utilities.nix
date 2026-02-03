{ config, lib, ... }: {
	programs = {
		# Show mouse refresh rate under Linux + evdev.
		evhz.install = true;

		# Utility for mapping events from Linux event devices.
		evsieve.install = true;

		# Simple joystick tester based on Gtk+.
		jstest-gtk.install = true;

		# RGB editor for the MiDiPlus SmartPad.
		midiplus-smartpad-rgb-editor.install = true;

		# User-mode driver and GUI for Steam Controller and other controllers.
		sc-controller.install = true;

		# Tools for working with USB devices, such as `lsusb`.
		usbutils.install = true;

		# Autoclicker for X11/XWayland programs.
		xclicker.install = true;

		# Generic Linux command-line automation tool.
		ydotool.enable = true;
	};

	# Add the user to the `ydotool` group.
	users.users.${config.userName}.extraGroups = lib.optional config.programs.ydotool.enable "ydotool";
}