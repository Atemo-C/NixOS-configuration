{ config, lib, pkgs, ... }: let cfg = config.programs.cmd-polkit; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.cmd-polkit = {
		enable = lib.mkEnableOption ''
			Whether to install cmd-polkit, a Polkit authentification utility to easily create polkit authentification agents by using commands.
		'';

		package = lib.mkPackageOption pkgs "cmd-polkit" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}