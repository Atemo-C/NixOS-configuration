{ config, lib, pkgs, ... }: let cfg = config.programs.unzip; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.unzip.install = lib.mkEnableOption ''
		Whether to install unzip, an extraction utility for archives compressed in .zip format.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.unzip;
}