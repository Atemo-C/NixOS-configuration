{ config, lib, pkgs, ... }: let cfg = config.services.easyeffects; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.services.easyeffects.enable = lib.mkEnableOption ''
		Whether to enable live audio effects for the user using EasyEffects.
	'';

	config = lib.mkIf cfg.enable {
		home-manager.users.${config.userName}.services.easyeffects.enable = true;
		programs.dconf.enable = true;
	};
}