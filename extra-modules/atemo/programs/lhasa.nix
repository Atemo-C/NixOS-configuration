{ config, lib, pkgs, ... }: let cfg = config.programs.lhasa; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lhasa.install = lib.mkEnableOption ''
		Whether to install lhasa, free software replacement for the Unix LHA tool.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lhasa;
}