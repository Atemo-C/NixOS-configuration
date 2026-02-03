{ config, lib, pkgs, ... }: let cfg = config.programs.vesktop; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.vesktop.install = lib.mkEnableOption ''
		Whether to install Vesktop, an alternate client for Discord with Vencord built-in.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.vesktop;
}