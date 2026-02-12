{ config, lib, pkgs, ... }: let cfg = config.programs.krita; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.krita.install = lib.mkEnableOption ''
		Whether to install Krita, a free and open source painting application.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.krita;
}