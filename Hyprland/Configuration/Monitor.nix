{ config, ... }: {

	# Monitor settings.
	# Name, Resolution@Rate, Position, Scale, Rotation.
	# https://wiki.hyprland.org/Configuring/Monitors/
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.monitor =
		", 1920x1080@120, 0x0, 1";
#		", 1920x1080@120, 0x0, 1, transform, 1";

}
