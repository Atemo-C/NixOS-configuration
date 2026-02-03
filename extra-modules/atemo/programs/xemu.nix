{ config, lib, pkgs, ... }: let cfg = config.programs.xemu; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xemu.install = lib.mkEnableOption ''
		Whether to install Xemu, an original Xbox emulator.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.xemu;
}