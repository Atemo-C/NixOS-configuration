{ config, lib, pkgs, ... }: let cfg = config.programs.efibootmgr; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.efibootmgr.install = lib.mkEnableOption ''
		Whether to install efibootmgr, a Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.efibootmgr;
}