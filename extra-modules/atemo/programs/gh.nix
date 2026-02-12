{ config, lib, pkgs, ... }: let cfg = config.programs.gh; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gh.install = lib.mkEnableOption ''
		Whether to install gh, a GitHub CLI tool.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gh;
}