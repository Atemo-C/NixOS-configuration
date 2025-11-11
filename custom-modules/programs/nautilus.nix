{ config, lib, pkgs, ... }: let cfg = config.programs.nautilus; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.nautilus = {
		enable = lib.mkEnableOption ''
			Whether to install Nautilus, GNOME's file manager.
		'';

		package = lib.mkPackageOption pkgs "nautilus" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}