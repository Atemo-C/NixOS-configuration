{ config, lib, pkgs, ... }: lib.optionals config.programs.niri.enable { environment.systemPackages = with pkgs; [
	evhz          # Show mouse refresh rate.
	evsieve       # Utility for mapping events from Linux event devices.
	jstest-gtk    # Graphical joystic tester.
	#sc-controller # User-mode driver and GUI for configuring any controller.
	usbutils      # Tools for working with USB devices, such as `lsusb`.
	xclicker      # Autoclicker for XWayland programs.
]; }