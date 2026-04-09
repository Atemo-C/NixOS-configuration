{ config, lib, pkgs, ... }: let cfg = config.programs.pwvucontrol; in {
	options.programs.pwvucontrol.enable = lib.mkEnableOption "pwvucontrol, a graphical PipeWire volume control utility.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.pwvucontrol;
}