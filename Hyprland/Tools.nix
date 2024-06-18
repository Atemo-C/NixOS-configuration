{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Wallpaper.
		unstable.hyprpaper

		# Notifications.
		dunst
		libnotify

		# Menus and scripts.
		gnome.zenity
		tofi

		# Brightness control.
		brightnessctl

		# Policykit agent.
		lxqt.lxqt-policykit

		# Bar.
		unstable.waybar
	];

}
