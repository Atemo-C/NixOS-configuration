# Used packages:
#───────────────
# • [lxqt-policykit]
# https://github.com/lxqt/lxqt-policykit
#
# • [hyprpaper]
# https://github.com/hyprwm/hyprpaper

{ pkgs, ... }: { environment.systemPackages = [

	# The LXQt PolicyKit agent.
	pkgs.lxqt.lxqt-policykit

	# A blazing fast wayland wallpaper utility.
	pkgs.unstable.hyprpaper

]; }
