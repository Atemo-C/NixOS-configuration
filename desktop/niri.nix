{ config, lib, pkgs, ... }: {
	programs = {
		# Whether to enable the Niri Wayland compositor.
		niri.enable = true;

		# FISH shell abbreviation for starting Niri.
		# FISH is toggleable in the `./user/shell.nix` module.
		fish.shellAbbrs = lib.mkIf (config.programs.niri.enable && config.programs.fish.enable) { n = "niri-session"; };
	};

	environment = lib.mkIf config.programs.niri.enable {
		# Ozone Wayland support for Chromium and Electron-based programs.
		sessionVariables.NIXOS_OZONE_WL = "1";

		# XWayland integration for Wayland compositors.
		# This is configured in the `./desktop/files/niri.kdl` file.
		# https://github.com/YaLTeR/niri/wiki/Xwayland
		systemPackages = [ pkgs.xwayland-satellite ];
	};

	# Link the configuration to the right place.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optional config.programs.niri.enable
	"L %h/.config/niri/config.kdl - - - - /etc/nixos/desktop/files/niri.kdl";
}