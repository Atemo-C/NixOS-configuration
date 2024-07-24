{ pkgs, ... }: {

	environment.systemPackages = with pkgs.unstable; [
		# OBS with the wlrobs plugin.
		(wrapOBS { plugins = with pkgs.unstable.obs-studio-plugins; [ wlrobs ]; } )

		# Xwayland video bridge for screensharing on Wayland with X11 programs.
		xwaylandvideobridge
	];

}
