{ config, lib, pkgs, ... }: let cfg = config.programs.pcsx2; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.pcsx2.install = lib.mkEnableOption ''
		Whether to install PCSX2, a Playstation 2 emulator.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.pcsx2;
}