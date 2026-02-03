{ config, lib, pkgs, ... }: let cfg = config.programs.f3d; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.f3d.install = lib.mkEnableOption ''
		Whether to install f3d, a fast and minimalist 3D viewer using VTK.
		Provides support for thumbnails of 3D files with compatible thumbnailers.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.f3d;
}