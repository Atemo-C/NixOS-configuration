{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Utility for mapping events from Linux event devices.
		evsieve

		# Tools for working with USB devices, such as lsusb.
		usbutils
	];

}
