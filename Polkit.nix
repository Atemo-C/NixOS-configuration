{ config, lib, pkgs, ... }: let

	# Polkit support; Toggleable in this module.
	polkit = config.security.polkit.enable;

	# Hyprland is toggleable in the `./Hyprland/Configuration.nix` module.
	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	# Whether to enable Polkit.
	security.polkit.enable = true;

	# QT Polkit agent for Hyprland.
	environment.systemPackages = lib.optionals (polkit && hyprland) [ pkgs.hyprpolkitagent ];

	# STart the QT Polkit agent in Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once =
		lib.optionals (polkit && hyprland) [ "systemctl --user start hyprpolkitagent" ];

}
