{ config, lib, pkgs, ... }: let cfg = config.programs.easytag; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.easytag = {
		enable = lib.mkEnableOption ''
			Whether to install EasyTag, an audio tag editor.
		'';

		package = lib.mkPackageOption pkgs "easytag" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}