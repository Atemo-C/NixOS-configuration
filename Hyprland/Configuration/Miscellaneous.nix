{ config, ... }: {

	# Miscellaneous settings.
	# https://wiki.hyprland.org/Configuring/Variables/#misc
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.misc = {
		disable_hyprland_logo = true;
		disable_splash_rendering = true;
		key_press_enables_dpms = true;
		mouse_move_enables_dpms = true;
		vrr = "0";
	};

}
