{ config, lib, pkgs, ... }: let cfg = config.programs.shellcheck; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.shellcheck = {
		enable = lib.mkEnableOption ''
			Whether to enable shellcheck, a shell script analysis tool.
		'';

		package = lib.mkPackageOption pkgs "shellcheck" {
			default = [ "shellcheck" ];
			example = [ "shellcheck-minimal" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}