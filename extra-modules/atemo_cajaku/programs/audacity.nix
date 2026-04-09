{ config, lib, pkgs, ... }: let cfg = config.programs.audacity; in {
	options.programs.audacity = {
		enable = lib.mkEnableOption "Audacity, a sound editor with graphical UI.";

		package = lib.mkPackageOption pkgs "audacity" {
			default = [ "audacity" ];
			example = [ "tenacity" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}