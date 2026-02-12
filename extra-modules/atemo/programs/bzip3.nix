{ config, lib, pkgs, ... }: let cfg = config.programs.bzip3; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.bzip3.install = lib.mkEnableOption ''
		Whether to install BZip3, a better and stronger spiritual successor to BZip2.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.bzip3;
}