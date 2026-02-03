{ config, lib, pkgs, ... }: let
	ozw = config.programs.niri.ozoneWayland;
	xwl = config.programs.niri.xwayland;
in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.niri = {
		ozoneWayland.enable = lib.mkEnableOption ''
			Whether to enable Ozone Wayland support for Chromium and Electron-based programs.
			This lets them run in a Wayland-native mode, instead of relying on Xwayland.
		'';

		xwayland = {
			enable = lib.mkEnableOption ''
				Whether to enable Xwayland support in Niri with xwayland-satellite.
			'';
		};
	};

	config.environment = {
		sessionVariables.NIXOS_OZONE_WL = lib.mkIf xwl.enable "1";

		systemPackages = lib.optional xwl.enable pkgs.xwayland-satellite;
	};
}