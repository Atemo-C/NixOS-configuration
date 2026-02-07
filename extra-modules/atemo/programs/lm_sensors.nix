{ config, lib, pkgs, ... }: let cfg = config.programs.lm_sensors; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lm_sensors.install = lib.mkEnableOption ''
		Whether to install lm_sensors, tools for reading hardware sensors - maintained fork.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.lm_sensors;
}