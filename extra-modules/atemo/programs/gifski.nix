{ config, lib, pkgs, ... }: let cfg = config.programs.gifski; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gifski.install = lib.mkEnableOption ''
		Whether to install gifski, a GIF encoder based on libimagequant (pngquant).
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.gifski;
}