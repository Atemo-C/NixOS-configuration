{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Wallpaper.
		unstable.hyprpaper

		# GTK menu thingy for scripts.
		gnome.zenity

		# Brightness control.
		brightnessctl

		# Policykit agent.
		lxqt.lxqt-policykit

		# Bar.
		unstable.waybar
	];

}
