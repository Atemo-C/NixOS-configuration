{ config, lib, pkgs, ... }: let cfg = config.programs.dtrx; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.dtrx.install = lib.mkEnableOption ''
		Whether to install DTRX (Do The Right Extraction), a tool for taking the hassle out of extracting archives.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.dtrx;
}