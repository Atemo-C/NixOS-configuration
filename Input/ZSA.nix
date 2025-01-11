{ config, pkgs, ... }: {

	# GUI and CLI flashing utilities for ZSA keyboards.
	environment.systemPackages = [ pkgs.keymapp pkgs.wally-cli ];

	# Whether to enable udev rules for ZSA keyboards.
	# Needed to flash firmware on the keyboards or use their live training in a Chromium-based web browser.
	hardware.keyboard.zsa.enable = true;

}
