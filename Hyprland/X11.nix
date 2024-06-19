{ config, pkgs, ... }: {

	# Legacy X11 tools.
	environment.systemPackages = with pkgs; [
		# Xorg's xrandr (see and change screen resolution).
		xorg.xrandr

		# Killall (kill all programs with the same name).
		killall

		# Xwayland (manually create Xwayland windows).
		xwayland

		# Openbox X11 window manager (can be ran inside a rootful Xwayland window).
		openbox
	];

}
