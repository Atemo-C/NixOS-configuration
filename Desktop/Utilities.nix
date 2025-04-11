{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# QT Polkit agent for Hyprland.
	hyprpolkitagent

	# Wallpaper utility.
	hyprpaper

	# Legacy X11 tools, mostly for Xwayland programs.
	xorg.xrandr

	# Keyring.
	gnome-keyring

]; }
