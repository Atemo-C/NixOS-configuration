{ config, pkgs, ... }: let

	Hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	environment.systemPackages = if Hyprland then [
		# Wallpaper utility.
		pkgs.hyprpaper

		# Legacy X11 tools, mostly for Xwayland programs.
		pkgs.xorg.xrandr

		# Keyring.
		pkgs.gnome-keyring
	] else [];

	# Start relevant utilities when logging into Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = if Hyprland then [
		# Start the wallpaper utility.
		"hyprpaper"

		# Start the keyring.
		"gnome-keyring-daemon"
	] else [];

}
