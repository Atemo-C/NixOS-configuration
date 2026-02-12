{ config, lib, pkgs, ... }: let cfg = config.programs.pwvucontrol; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.pwvucontrol.install = lib.mkEnableOption ''
		Whether to install pwvucontrol, a graphical PipeWire volume control utility.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.pwvucontrol;
}