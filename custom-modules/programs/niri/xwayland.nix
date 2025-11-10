{ config, lib, pkgs, ... }: let cfg = config.programs.niri.xwayland; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.niri.xwayland = {
		enable = lib.mkEnableOption ''
			Whether to enable XWayland support in Niri with the XWayland Satellite.
		'';

		package = lib.mkPackageOption pkgs "xwayland-satellite" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}