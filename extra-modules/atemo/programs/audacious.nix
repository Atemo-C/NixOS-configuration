{ config, lib, pkgs, ... }: let cfg = config.programs.audacious; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.audacious = {
		enable = lib.mkEnableOption ''
			Whether to install Audacious, a lightweight and versatile audio player.
		'';

		package = lib.mkPackageOption pkgs "audacious" {
			default = [ "audacious" ];
			example = [ "audacious-bare" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}