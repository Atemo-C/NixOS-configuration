{ config, lib, pkgs, ... }: let cfg = config.programs.qpwgraph; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.qpwgraph.install = lib.mkEnableOption ''
		Whether to install qpwgraph, a Qt graph manager for PipeWire, similar to QjackCtl.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.qpwgraph;
}