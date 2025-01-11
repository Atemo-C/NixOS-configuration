{ pkgs, ... }: { environment.systemPackages = [

	# LXQt PolicyKit agent.
	pkgs.unstable.lxqt.lxqt-policykit

	# Wallpaper utility.
	pkgs.unstable.hyprpaper

	# Legacy X11 tools, mostly for Xwayland programs.
	pkgs.xorg.xrandr

]; }
