{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		evsieve       # Utility for mapping events from Linux event devices.
		usbutils      # Tools for working with USB devices, such as `lsusb`.
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		evhz          # Show mouse refresh rate.
		jstest-gtk    # Graphical joystic tester.
		#sc-controller # User-mode driver and GUI for configuring any controller.
		xclicker      # Autoclicker for XWayland programs.
	]);

	# Whether to enable ydotool system service and ydotool for members of `programs.ydotool.group`.
	programs.ydotool.enable = true;

	# Add the user to the `ydotool` group.
	users.users.${config.userName}.extraGroups = [ "ydotool" ];
}