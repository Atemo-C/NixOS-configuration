{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.hardware.keyboard.zsa.enable (with pkgs; [
		# Graphical utility for ZSA keyboards.
		keymapp

		# CLI tool to flash firmware onto mechanical keyboards like ZSA's.
		wally-cli
	]);

	# Whether to enable udev rules for keyboards from ZSA.
	# This is necessary to make the above programs (and more) work.
	hardware.keyboard.zsa.enable = true;
}