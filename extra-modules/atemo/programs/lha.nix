{ config, lib, pkgs, ... }: let cfg = config.programs.lha; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lha.install = lib.mkEnableOption ''
		Whether to install lha, free software replacement for the Unix LHA tool.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lha;
}