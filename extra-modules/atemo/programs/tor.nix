{ config, lib, pkgs, ... }: let cfg = config.programs.tor; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.tor.install = lib.mkEnableOption ''
		Whether to install tor, an anonymizing overlay network.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.tor;
}