{ pkgs, ... }: { environment.systemPackages = [

	# QT Polkit agent for Hyprland.
	( if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
		pkgs.hyprpolkitagent else null )

	# Wallpaper utility.
	( if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
		pkgs.hyprpaper else null )

	# Legacy X11 tools, mostly for Xwayland programs.
	pkgs.xorg.xrandr

	# Keyring.
	pkgs.gnome-keyring

]; }
