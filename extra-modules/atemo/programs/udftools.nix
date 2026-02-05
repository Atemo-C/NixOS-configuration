{ config, lib, pkgs, ... }: let cfg = config.programs.udftools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.udftools.install = lib.mkEnableOption ''
		Whether to install udftools, UDF tools.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.udftools;
}