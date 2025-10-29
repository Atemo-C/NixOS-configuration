{ config, lib, pkgs, ... }: let cfg = config.programs.qpwgraph; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.qpwgraph = {
		enable = lib.mkEnableOption ''
			Whether to install qpwgraph, a Qt graph manager for PipeWire similar to QjackCtl.
		'';

		package = lib.mkPackageOption pkgs "qpwgraph" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}