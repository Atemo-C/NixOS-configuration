{ config, lib, pkgs, ... }: {
	# Whether to enable full support for ZSA keyboards.
	# Needed to flash firmware on them, and use the Oryx live training in a Chromium-based web browser.
	hardware.keyboard.zsa.enable = true;

	# CLI and graphical utilities for ZSA keyboards.
	environment.systemPackages = lib.optional config.hardware.keyboard.zsa.enable pkgs.wally-cli ++
		lib.optional (config.hardware.keyboard.zsa.enable && config.programs.niri.enable) pkgs.keymapp;
}