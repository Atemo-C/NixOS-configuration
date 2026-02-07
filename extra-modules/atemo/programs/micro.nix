{ config, lib, pkgs, ... }: let cfg = config.programs.micro; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.micro = {
		enable = lib.mkEnableOption ''
			Whether to enable Micro, a modern and intuitive terminal-based text editor.
		'';

		package = lib.mkPackageOption pkgs "micro" {
			default = [ "micro" ];
			example = [ "micro-with-wl-clipboard" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}