{ config, ... }: {

	# Various decorations.
	# https://wiki.hyprland.org/Configuring/Variables/#decoration
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.decoration = {
		# Blur settings.
		# https://wiki.hyprland.org/Configuring/Variables/#blur
		blur = {
			brightness = "1";
			contrast = "1";
			enabled = false;
			noise = "0";
			size = "3";
			vibrancy = "0";
			xray = true;
		};

		"col.shadow" = "rgba(00b0ffcc)";
		"col.shadow_inactive" = "rgba(000000cc)";
		drop_shadow = true;
		shadow_range = "6";
		shadow_render_power = "10";
	};

}
