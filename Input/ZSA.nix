{ config, pkgs, ... }: rec {

	# Whether to enable udev rules for ZSA keyboards.
	# Needed to flash firmware on the keyboards or use their live training in a Chromium-based web browser.
	hardware.keyboard.zsa.enable = true;

	# GUI and CLI flashing utilities for ZSA keyboards.
	environment.systemPackages = [
		( if hardware.keyboard.zsa.enable then pkgs.keymapp else null )
		( if hardware.keyboard.zsa.enable then pkgs.wally-cli else null )
	];

}
