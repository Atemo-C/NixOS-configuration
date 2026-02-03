{ config, lib, pkgs, ... }: let cfg = config.programs.desmume; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.desmume.install = lib.mkEnableOption ''
		Whether to install DeSmuME, an open-source Nintendo DS emulator.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.desmume;
}