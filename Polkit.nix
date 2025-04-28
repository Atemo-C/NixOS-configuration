{ config, pkgs, ... }: {

	# Enable Polkit.
	security.polkit.enable = true;

	# QT Polkit agent for the Hyprland Wayland compositor.
	environment.systemPackages = [
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			pkgs.hyprpolkitagent else null)
	];

	# Start the Polkit agent in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = [
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			"systemctl --user start hyprpolkitagent" else null
		)
	];

}
