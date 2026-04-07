{ config, lib, pkgs, ... }: let cfg = config.programs.ydotool; in {
	users.users.${config.user.name}.extraGroups = lib.optional cfg.enable "ydotool";
}