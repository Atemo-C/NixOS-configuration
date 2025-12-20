{ config, lib, ... }: {
	programs = {
		# Show mouse refresh rate under Linux + evdev.
		evhz.enable = lib.mkIf config.programs.niri.enable true;

		# Utility for mapping events from Linux event devices.
		evsieve.enable = true;

		# Simple joystick tester based on Gtk+.
		jstest-gtk.enable = lib.mkIf config.programs.niri.enable true;

		# RGB editor for the MiDiPlus SmartPad.
		midiplus-smartpad-rgb-editor.enable = lib.mkIf config.programs.niri.enable true;

		# User-mode driver and GUI for Steam Controller and other controllers.
		sc-controller.enable = lib.mkIf config.programs.niri.enable true;

		# Tools for working with USB devices, such as `lsusb`.
		usbutils.enable = true;

		# Autoclicker for X11/XWayland programs.
		xclicker.enable = lib.mkIf (config.programs.niri.enable && config.programs.niri.xwayland.enable) true;

		# Generic Linux command-line automation tool.
		ydotool.enable = lib.mkIf config.programs.niri.enable true;
	};
}