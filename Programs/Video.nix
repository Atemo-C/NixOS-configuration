{ config, pkgs, ... }: {

	# V4L2 kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = [
		# Utility to allow streaming Wayland windows to X applications.
		pkgs.kdePackages.xwaylandvideobridge

		# Free and open source video editor, based on MLT Framework and KDE Frameworks.
		pkgs.kdePackages.kdenlive

		# Open Source YouTube app for privacy.
		pkgs.freetube

		# General-purpose media player, fork of MPlayer and mplayer2.
		(pkgs.mpv.override { scripts = [
				pkgs.mpvScripts.mpris
				pkgs.mpvScripts.sponsorblock
			];
		})

		# A complete, cross-platform solution to record, convert and stream audio and video.
		pkgs.ffmpeg-full

		# Open h.265 video codec implementation.
		pkgs.libde265

		# V4L utils and libv4l, provide common image formats regardless of the v4l device.
		pkgs.v4l-utils
	];

}
