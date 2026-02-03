{ config, lib, pkgs, ... }: let cfg = config.programs.gimp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gimp = {
		enable = lib.mkEnableOption ''
			Whether to enable GIMP, the GNU Image Manipulation Program.
		'';

		package = lib.mkPackageOption pkgs "gimp" {
			default = [ "gimp" ];
			example = [ "gimp-with-plugins" ];
		};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}