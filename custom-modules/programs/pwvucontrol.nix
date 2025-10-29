{ config, lib, pkgs, ... }: let cfg = config.programs.pwvucontrol; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.pwvucontrol = {
		enable = lib.mkEnableOption ''
			Whether to install the pwvucontrol PipeWire volume control utility.
			It aims to replace `pavucontrol`, and you should feel free to remove the latter if installed.
		'';

		package = lib.mkPackageOption pkgs "pwvucontrol" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}