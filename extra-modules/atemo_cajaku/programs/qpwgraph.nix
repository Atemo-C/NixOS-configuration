{ config, lib, pkgs, ... }: let cfg = config.programs.qpwgraph; in {
	options.programs.qpwgraph.enable = lib.mkEnableOption "qpwgraph, a QT graph manager for PipeWire, similar to QjackCtl.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.qpwgraph;
}