{ config, pkgs, ... }: let zsa = config.hardware.keyboard.zsa.enable; in {

	# Whether to enable the necessary udev rules for ZSA keyboards.
	# Needed to flash firmware on the keyboards or use their live training in a Chromium-based web browser.
	hardware.keyboard.zsa.enable = true;

	# GUI and CLI flashing utilities for ZSA keyboards.
	environment.systemPackages = if zsa then [
		pkgs.keymapp
		pkgs.wally-cli
	] else [];

}
