{ config, lib, pkgs, ... }: let niri = config.programs.niri.enable; fish = config.programs.fish.enable in {
	# Whether to enable the Niri Wayland compositor.
	programs.niri.enable = true;

	# Shell abbreviation for starting Niri.
	programs.fish.shellAbbrs = lib.mkIf (niri && fish) { n = "niri --session -c /etc/nixos/desktop/files/niri.kdl"; };

	environment = lib.mkIf niri {
		# Ozone Wayland support for Chromium and Electron-based programs.
		sessionVariables.NIXOS_OZONE_WL = "1";

		# XWayland integration.
		systemPackages = [ pkgs.xwayland-satellite ];
	};
}