{ config, ... }: {

	# Animations.
	# https://wiki.hyprland.org/Configuring/Variables/#animations
	# https://wiki.hyprland.org/Configuring/Animations/
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.animations = {
		# Whether to enable animations.
		enabled = true;

		# Whether to enable the first launch animation.s
		first_launch_animation = false;

		# Animation curve.
		# Name, X0, Y0, X1, Y1
		bezier = "Simple, 0.3, 1, 0.3, 1";

		# Animation settings.
		# Type, Toggle, Time, Curve, Style
		animation = [
			"windows, 1, 3, Simple"
			"windowsOut, 1, 3, Simple, popin 50%"
			"border, 1, 3, Simple"
			"borderangle, 1, 3, Simple"
			"fade, 1, 3, Simple"
			"workspaces, 1, 3, Simple"
		];
	};

}
