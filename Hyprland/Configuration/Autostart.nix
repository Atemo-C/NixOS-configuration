{ config, ... }: {

	# # List of commands to execute at Hyprland's startup.
	# https://wiki.hyprland.org/FAQ/#how-do-i-autostart-my-favorite-apps
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings.exec-once = [
		# Wallpaper.
		"hyprpaper"

		# Policykit agent.
		"exec-once = lxqt-policykit-agent"

		# File manager as a background daemon.
		"thunar --daemon"

		# Bar.
		''waybar -c "$HOME/.config/waybar/config.json"''

		# Clipboard.
		"wl-paste -t text --watch clipman store --no-persist --max-items=30"

		# Screen-sharing for some legacy X11 programs.
#		"xwaylandvideobridge"

		# Audio tweaking with Easy Effects.
		"easyeffects --gapplication-service"
	];

}
