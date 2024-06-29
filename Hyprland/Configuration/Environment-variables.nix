{ config, ... }: {

	# Environment variables.
	# https://wiki.hyprland.org/Configuring/Environment-variables/
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.env = [
		# Backend settings
		"SDL_VIDEODRIVER, wayland"
		"CLUTTER_BACKEND, wayland"

		# QT settings
		"QT_AUTO_SCREEN_SCALE_FACTOR, 1"
		"QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

		# NVIDIA-specific variables
		"GBM_BACKEND, nvidia-drm"
		"__GLX_VENDOR_LIBRARY_NAME, nvidia"
		"LIBVA_DRIVER_NAME, nvidia"
		"__GL_GSYNC_ALLOWED, 1"
		"__GL_VRR_ALLOWED, 1"
		"WLR_DRM_NO_ATOMIC, 1"

		# Graphics adapter to use for Hyprland
		"WLR_DRM_DEVICES, /dev/dri/card1"
	];

}
