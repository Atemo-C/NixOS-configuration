{ config, lib, pkgs, ... }: let cfg = config.programs.networkmanager; in {
	users.users.${config.user.name}.extraGroups = lib.optional cfg.enable "networkmanager";
}