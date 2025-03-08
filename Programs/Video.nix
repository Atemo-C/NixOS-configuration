{ config, pkgs, ... }: {

	# V4L2 kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = with pkgs; [
		# Utility to allow streaming Wayland windows to X applications.
		kdePackages.xwaylandvideobridge

		# Free and open source video editor, based on MLT Framework and KDE Frameworks.
		kdePackages.kdenlive

		# Open Source YouTube app for privacy.
		freetube

		# General-purpose media player, fork of MPlayer and mplayer2.
		(mpv.override { scripts = [
			mpvScripts.mpris
			mpvScripts.sponsorblock
		]; })

		# A complete, cross-platform solution to record, convert and stream audio and video.
		ffmpeg-full

		# Open h.265 video codec implementation.
		libde265

		# V4L utils and libv4l, provide common image formats regardless of the v4l device.
		v4l-utils
	];

	# Free and open source software for video recording and live streaming, with the wlrobs plugin.
	programs.obs-studio = {
		# Whether to enable OBS Studio for video recording and live streaming.
		enable = true;

		# Whether to install and set up the v4l2loopback kernel module.
		# Necessary for OBS to start a virtual camera.
		enableVirtualCamera = true;

		# Overrides for OBS Studio.
#		package = (pkgs.obs-studio.override { cudaSupport = true; });

		# Which plugins to add to OBS Studio.
		plugins = [ pkgs.obs-studio-plugins.wlrobs ];
	};

}
