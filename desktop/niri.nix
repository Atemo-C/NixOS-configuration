{ config, lib, pkgs, ... }: let niri = config.programs.niri.enable; fish = config.programs.fish.enable; in {
	# Whether to enable the Niri Wayland compositor.
	programs.niri.enable = true;

	# Shell abbreviation for starting Niri.
	programs.fish.shellAbbrs = lib.mkIf (niri && fish) { n = "niri-session"; };

	environment = lib.mkIf niri {
		# Ozone Wayland support for Chromium and Electron-based programs.
		sessionVariables.NIXOS_OZONE_WL = "1";

		# XWayland integration.
		systemPackages = [ pkgs.xwayland-satellite ];
	};

	# Link the configuration file of Niri.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optional config.programs.niri.enable
	"L %h/.config/niri/config.kdl - - - - /etc/nixos/desktop/files/niri.kdl";
}