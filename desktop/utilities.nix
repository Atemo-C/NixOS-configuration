{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# Polkit authentification utility to be used with dmenu-like menus.
		cmd-polkit

		# Keyring utility from the GNOME desktop.
		gnome-keyring

		# Wayland wallpaper utility.
		hyprpaper

		# Polkit authentification agent.
		#hyprpolkitagent

		# Nautilus file manager; Only here for file picking as Niri uses the GNOME XDG Portal.
		nautilus

		# Display graphical dialogs from the command-line and shell scripts.
		zenity
	]);
}