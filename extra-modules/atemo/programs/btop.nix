{ config, lib, pkgs, ... }: let cfg = config.programs.btop; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.btop = {
		enable = lib.mkEnableOption ''
			Whether to enable BTOP, a monitor of resources.
		'';

		package = lib.mkPackageOption pkgs "btop" {
			default = [ "btop" ];
			example = [ "btop-cuda" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}