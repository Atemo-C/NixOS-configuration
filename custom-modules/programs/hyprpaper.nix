{ config, lib, pkgs, ... }: let cfg = config.programs.hyprpaper; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.hyprpaper = {
		enable = lib.mkEnableOption ''
			Whether to install hyprpaper, a fast Wayland wallpaper utility.
		'';

		package = lib.mkPackageOption pkgs "hyprpaper" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}