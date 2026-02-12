{ config, lib, pkgs, ... }: let cfg = config.programs.parallel; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.parallel = {
		enable = lib.mkEnableOption ''
			Whether to enable parallel, a shell tool for executing jobs in parallel.
		'';

		package = lib.mkPackageOption pkgs "parallel" {
			default = [ "parallel" ];
			example = [ "parallel-full" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}