{ config, ... }: {

	# General configuration options.
	# https://wiki.hyprland.org/Configuring/Variables/#general
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.general = {
		"col.active_border" = "rgb(0080ff)";
		"col.inactive_border" = "rgb(121212)";
		extend_border_grab_area = "10";
		gaps_in = "3";
		gaps_out = "3";
		resize_on_border = true;
	};

}
