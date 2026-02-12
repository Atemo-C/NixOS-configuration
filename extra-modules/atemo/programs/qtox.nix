{ config, lib, pkgs, ... }: let cfg = config.programs.qtox; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.qtox.install = lib.mkEnableOption ''
		Whether to install qTox, a Qt Tox client.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.qtox;
}