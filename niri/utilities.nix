{ config, lib, ... }: lib.mkIf config.programs.niri.enable {
	programs = {
		# Polkit authentification utility to be used with dmenu-like menus.
		cmd-polkit.enable = true;

		# Wayland wallpaper utility.
		hyprpaper.enable = true;

		# Display graphical dialogs from the command-line and shell scripts.
		zenity.enable = true;
	};

	# Keyring utility from the GNOME desktop.
	services.gnome.gnome-keyring.enable = true;
}