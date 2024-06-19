{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# OBS with the wlrobs plugin.
		(pkgs.wrapOBS { plugins = with pkgs.obs-studio-plugins; [ wlrobs ]; } )

		# Xwayland video bridge for screensharing on Wayland with X11 programs.
		unstable.xwaylandvideobridge
	];

}
