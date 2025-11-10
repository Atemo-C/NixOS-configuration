{ config, lib, pkgs, ... }: let cfg = config.programs.niri.ozoneWayland; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.niri.ozoneWayland = {
		enable = lib.mkEnableOption ''
			Whether to enable Ozone Waylandsupport for Chromium and Electron-based programs.
			This allows them to run in a Wayland-native mode if supported, instead of relying on XWayland.
		'';
	};

	config.environment.sessionVariables.NIXOS_OZONE_WL = lib.mkIf cfg.enable "1";
}