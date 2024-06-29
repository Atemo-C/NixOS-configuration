{ config, ... }: {

	# Dwindle layout configuration.
	# https://wiki.hyprland.org/Configuring/Dwindle-Layout/
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.dwindle = {
		no_gaps_when_only = "1";
		preserve_split = true;
		smart_split = true;
	};

}
