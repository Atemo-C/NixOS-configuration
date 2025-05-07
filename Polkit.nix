{ config, pkgs, ... }: let

	polkit = config.security.polkit.enable;
	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	# Whether to enable Polkit.
	security.polkit.enable = true;

	# QT Polkit agent for Hyprland.
	environment.systemPackages = if hyprland && polkit then [ pkgs.hyprpolkitagent ] else [];

	# Start the Polkit agent in Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = if
		polkit && hyprland then [ "systemctl --user start hyprpolkitagent" ] else [];

}
