{ config, pkgs, ... }: {

	environment.systemPackages = [
		# Wallpaper utility.
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			pkgs.hyprpaper else null)

		# Legacy X11 tools, mostly for Xwayland programs.
		pkgs.xorg.xrandr

		# Keyring.
		pkgs.gnome-keyring
	];

	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = [
		# Start the wallpaper utility in the Hyprland Wayland compositor.
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			"hyprpaper" else null)

		# Start the keyring in the Hyprland Wayland compositor.
		(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
			"gnome-keyring-daemon" else null)
	];
}
