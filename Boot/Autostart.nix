# Documentation:
#───────────────
# • https://wiki.hyprland.org/FAQ/#how-do-i-autostart-my-favorite-apps

# Programs to start when logging into the desktop.
{ config, ... }: { home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.exec-once = [

	# Audio tweaks with Easy Effects.
	"easyeffects --gapplication-service"

	# Wallpaper.
	"hyprpaper"

	# Policykit agent.
	"lxqt-policykit-agent"

	# Clipboard manager.
	"wl-paste -t text --watch clipman store --no-persist --max-items=100"

	# Screen sharing for legacy X11 programs.
#	"xwaylandvideobridge"

]; }
