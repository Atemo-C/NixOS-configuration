{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# Mind-mapping utility.
		minder

		# Offline password manager.
		keepassxc
	]);
}