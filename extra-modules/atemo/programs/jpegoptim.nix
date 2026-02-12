{ config, lib, pkgs, ... }: let cfg = config.programs.jpegoptim; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jpegoptim.install = lib.mkEnableOption ''
		Whether to install jpegoptim, a tool to optimize JPEG files.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.jpegoptim;
}