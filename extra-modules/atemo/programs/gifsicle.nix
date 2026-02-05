{ config, lib, pkgs, ... }: let cfg = config.programs.gifsicle; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gifsicle.install = lib.mkEnableOption ''
		Whether to install Gifsicle, a command-line tool for creating, editing, and getting information about GIF images and animations.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gifsicle;
}