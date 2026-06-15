{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Show mouse refresh rate under Linux + evdev.
		evhz

		# Utility for mapping events from Linux event devices.
		evsieve

		# Simple GTK joystic tester.
		jstest-gtk

		# Cozy typing speed tester in the terminal.
		typioca

		# Tools for working with USB devices, such as `lsusb`.
		usbutils
	];

	# Whether to enable the ydotool system service,
	# a generic Linux command-line automation tool.
	programs.ydotool.enable = true;

	# Add the user to the `ydotool` group.
	users.users.${config.user.name}.extraGroups = lib.optional config.programs.ydotool.enable "ydotool";
}