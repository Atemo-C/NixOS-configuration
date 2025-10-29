{ config, lib, pkgs, ... }: let cfg = config.programs.audacity; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.audacity = {
		enable = lib.mkEnableOption ''
			Whether to install Audacity, a sound editor with a graphical UI.
		'';

		package = lib.mkPackageOption pkgs "audacity" {
			default = [ "audacity" ];
			example = [ "tenacity" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}