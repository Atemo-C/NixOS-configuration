{ config, pkgs, ... }: let

	Polkit = config.security.polkit.enable;
	Hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	# Whether to enable Polkit.
	security.polkit.enable = true;

	# QT Polkit agent for Hyprland.
	environment.systemPackages = if Hyprland then [ pkgs.hyprpolkitagent ] else [];

	# Start the Polkit agent in Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = if
		Polkit && Hyprland then [ "systemctl --user start hyprpolkitagent" ] else [];

}
