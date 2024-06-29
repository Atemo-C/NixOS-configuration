{ config, ... }: {

	# Input settings.
	# https://wiki.hyprland.org/Configuring/Variables/#input
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.input = {
		accel_profile = "flat";
		kb_layout = "fr";
		numlock_by_default = true;
		repeat_delay = "200";
		repeat_rate = "30";
		scroll_method = "2fg";

		# Touchpad settings
		# https://wiki.hyprland.org/Configuring/Variables/#touchpad
		touchpad = {
			disable_while_typing = false;
			clickfinger_behavior = true;
		};
	};

}
