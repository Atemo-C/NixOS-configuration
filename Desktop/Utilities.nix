{ pkgs, ... }: { environment.systemPackages = [

	# QT Polkit agent for Hyprland.
	pkgs.hyprpolkitagent

	# Wallpaper utility.
	pkgs.hyprpaper

	# Legacy X11 tools, mostly for Xwayland programs.
	pkgs.xorg.xrandr

	# Keyring.
	pkgs.gnome-keyring

]; }
