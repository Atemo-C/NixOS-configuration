{ config, lib, pkgs, ... }: let cfg = config.programs.shellcheck; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.shellcheck = {
		install = lib.mkEnableOption ''
			Whether to install shellcheck, a shell script analysis tool.
		'';

		package = lib.mkPackageOption pkgs "shellcheck" {
			default = [ "shellcheck" ];
			example = [ "shellcheck-minimal" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}