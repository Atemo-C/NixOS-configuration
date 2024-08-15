{ config, ... }: {

	# Rendering.
	# https://wiki.hyprland.org/Configuring/Variables/#render
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.render = {
		# Whether to enable explicit sync.
		explicit_sync = 0;

		# Whether to enable direct scanout.
		direct_scanout = false;
	};

}
