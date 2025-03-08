{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# LXQt PolicyKit agent.
	lxqt.lxqt-policykit

	# Wallpaper utility.
	hyprpaper

	# Legacy X11 tools, mostly for Xwayland programs.
	xorg.xrandr

]; }
