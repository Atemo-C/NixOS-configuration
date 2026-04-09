{ config, lib, pkgs, ... }: let cfg = config.programs.audacious; in {
	options.programs.audacious = {
		enable = lib.mkEnableOption "Audacious, a lightweight and versatile audio player.";

		package = lib.mkPackageOption pkgs "audacious" {
			default = [ "audacious" ];
			example = [ "audacious-bare" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}