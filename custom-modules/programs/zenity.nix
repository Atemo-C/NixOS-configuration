{ config, lib, pkgs, ... }: let cfg = config.programs.zenity; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.zenity = {
		enable = lib.mkEnableOption ''
			Whether to install Zenity, a tool to display dialogs from the commandline and shell scripts.
		'';

		package = lib.mkPackageOption pkgs "zenity" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}