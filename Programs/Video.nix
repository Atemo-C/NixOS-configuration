{ config, pkgs, ... }: {

	# V4L2 kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = with pkgs; [
		# Free and open source software for video recording and live streaming, with the wlrobs plugin.
		(wrapOBS { plugins = with pkgs.unstable.obs-studio-plugins; [ wlrobs ]; } )

		# Utility to allow streaming Wayland windows to X applications.
		unstable.xwaylandvideobridge

		# Free and open source video editor, based on MLT Framework and KDE Frameworks.
		kdePackages.kdenlive

		# Open Source YouTube app for privacy.
		freetube

		# General-purpose media player, fork of MPlayer and mplayer2.
		mpv

		# A complete, cross-platform solution to record, convert and stream audio and video.
		ffmpeg_7-full

		# Open h.265 video codec implementation.
		libde265

		# V4L utils and libv4l, provide common image formats regardless of the v4l device.
		v4l-utils
	];

	# MPV plugins.
	nixpkgs.overlays = with pkgs; [
		(self: super: {
			mpv = super.mpv.override {
				scripts = [
					# MPRIS plugin for mpv.
					self.mpvScripts.mpris

					# Script for mpv to skip sponsored segments of YouTube videos.
					self.mpvScripts.sponsorblock
				];
			};
		})
	];

}
