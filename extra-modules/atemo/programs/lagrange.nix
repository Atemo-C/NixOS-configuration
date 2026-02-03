{ config, lib, pkgs, ... }: let cfg = config.programs.lagrange; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.lagrange = {
		enable = lib.mkEnableOption ''
			Whether to enable Lagrange, a beautiful Gemini client.
		'';

		package = lib.mkPackageOption pkgs "lagrange" {
			default = [ "lagrange" ];
			example = [ "lagrange-tui" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}