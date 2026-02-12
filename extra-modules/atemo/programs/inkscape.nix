{ config, lib, pkgs, ... }: let cfg = config.programs.inkscape; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.inkscape = {
		enable = lib.mkEnableOption ''
			Whether to enable Inkscape, a vector graphics editor.
		'';

		package = lib.mkPackageOption pkgs "inkscape" {
			default = [ "inkscape" ];
			example = [ "inkscape-with-plugins" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable pkgs.inkscape;
}