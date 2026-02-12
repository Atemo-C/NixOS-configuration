{ config, lib, pkgs, ... }: let cfg = config.programs.tlrc; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.tlrc.install = lib.mkEnableOption ''
		Whether to install tlrc, the official tldr client written in Rust.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.tlrc;
}