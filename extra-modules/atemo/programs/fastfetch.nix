{ config, lib, pkgs, ... }: let cfg = config.programs.fastfetch; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.fastfetch.install = lib.mkEnableOption ''
		Whether to install Fastfetch, an actively maintained, feature-rich and performance oriented, neofetch like system information tool.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.fastfetch;
}