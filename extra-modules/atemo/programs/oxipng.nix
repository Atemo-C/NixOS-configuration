{ config, lib, pkgs, ... }: let cfg = config.programs.oxipng; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.oxipng.install = lib.mkEnableOption ''
		Whether to install Oxipng, a multithreaded lossless PNG compression optimizer.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.oxipng;
}