{ config, lib, pkgs, ... }: let cfg = config.programs.easytag; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.easytag.install = lib.mkEnableOption ''
		Whether to install EasyTag, a tool to view and edit tags for various audio files.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.easytag;
}