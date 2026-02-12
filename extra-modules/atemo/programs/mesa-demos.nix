{ config, lib, pkgs, ... }: let cfg = config.programs.mesa-demos; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.mesa-demos.install = lib.mkEnableOption ''
		Whether to install Mesa Demos, a collection of demos and test programs for OpenGL and Mesa.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.mesa-demos;
}