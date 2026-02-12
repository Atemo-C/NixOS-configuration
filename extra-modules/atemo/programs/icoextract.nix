{ config, lib, pkgs, ... }: let cfg = config.programs.icoextract; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.icoextract.install = lib.mkEnableOption ''
		Whether to install icoextract, a tool to extract icons from Windows PE files.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.icoextract;
}