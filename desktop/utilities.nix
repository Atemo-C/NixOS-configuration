{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
	environment.systemPackages = with pkgs; [
		cmd-polkit    # Polkit authentification utility to be used with dmenu-like menus.
		hyprpaper     # Wayland wallpaper utility.
		nautilus      # Nautilus file manager; Only here for file picking as Niri uses the GNOME XDG Portal.
		zenity        # Display graphical dialogs from the command-line and shell scripts.
	];

	# Keyring utility from the GNOME desktop.
	services.gnome.gnome-keyring.enable = true;
}