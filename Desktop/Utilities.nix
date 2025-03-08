{ pkgs, ... }: { environment.systemPackages = [

	# LXQt PolicyKit agent.
	pkgs.lxqt.lxqt-policykit

	# Wallpaper utility.
	pkgs.hyprpaper

	# Legacy X11 tools, mostly for Xwayland programs.
	pkgs.xorg.xrandr

]; }
