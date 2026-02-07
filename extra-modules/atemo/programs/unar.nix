{ config, lib, pkgs, ... }: let cfg = config.programs.unar; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.unar.install = lib.mkEnableOption ''
		Whether to install unar, an archive unpacker program.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.unar;
}