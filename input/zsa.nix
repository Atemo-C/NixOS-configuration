{ config, lib, pkgs, ... }: rec {
	# Enable udev rules for keyboards from ZSA;
	# Like the ErgoDox EZ, Plank EZ, Moonlander Mark I, or Voyager.
	# The programs in this module require this to be enabled to work properly.
	hardware.keyboard.zsa.enable = true;

	environment.systemPackages = lib.optionals hardware.keyboard.zsa.enable (with pkgs; [
		# Graphical flashing and utility program for ZSA keyboards.
		keymapp

		# CLI flashing utility for ZSA keyboards.
		wally-cli
	]);
}