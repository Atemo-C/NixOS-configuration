{ config, lib, pkgs, ... }: let cfg = config.programs.jq; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jq.install = lib.mkEnableOption ''
		Whether to install jq, a lightweight and flexible command-line JSON processor.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.jq;
}