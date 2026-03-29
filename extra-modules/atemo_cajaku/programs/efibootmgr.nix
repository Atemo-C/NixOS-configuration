{ config, lib, pkgs, ... }: let cfg = config.programs.efibootmgr; in {
	options.programs.efibootmgr.enable = lib.mkEnableOption "efibootmgr, a Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.efibootmgr;
}