{ config, lib, pkgs, ... }: let cfg = config.programs.mgba; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.mgba.install = lib.mkEnableOption ''
		Whether to install mGBA, a modern GBA emulator with a focus on accuracy.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.mgba;
}