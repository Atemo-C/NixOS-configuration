# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/MPV
# • https://wiki.nixos.org/wiki/OBS_Studio
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=boot.extraModulePackages
# • https://search.nixos.org/options?channel=24.05&show=boot.initrd.kernelModules
#
# Used NixOS packages:
#─────────────────────
# • [obs-studio]
#   https://obsproject.com/
#
# • [wlrobs]
#   https://hg.sr.ht/~scoopta/wlrobs
#
# • [xwaylandvideobridge]
#   https://invent.kde.org/system/xwaylandvideobridge
#
# • [kdenlive]
#   https://invent.kde.org/multimedia/kdenlive
#
# • [freetube]
#   https://freetubeapp.io/
#
# • [mpv]
#   https://mpv.io/
#
# • [ffmpeg]
#   https://www.ffmpeg.org/
#
# • [libde265]
#   https://github.com/strukturag/libde265
#
# • [v4l-utils]
#   https://linuxtv.org/projects.php
#
# • [mpris mpv script]
#   https://github.com/hoyon/mpv-mpris
#
# • [sponsorblock mpv script]
#   https://github.com/po5/mpv_sponsorblock

{ config, pkgs, ... }: {

	# V4L2 kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = with pkgs; [
		# Video capture.
		## Free and open source software for video recording and live streaming, with the wlrobs plugin.
		(wrapOBS { plugins = with pkgs.unstable.obs-studio-plugins; [ wlrobs ]; } )

		# Utility to allow streaming Wayland windows to X applications.
		unstable.xwaylandvideobridge

		# Video editing.
		## Free and open source video editor, based on MLT Framework and KDE Frameworks.
		kdePackages.kdenlive

		# Video playing.
		## Open Source YouTube app for privacy.
		freetube

		## General-purpose media player, fork of MPlayer and mplayer2.
		mpv

		# Video utilities.
		## A complete, cross-platform solution to record, convert and stream audio and video.
		ffmpeg_7-full

		## Open h.265 video codec implementation.
		libde265

		## V4L utils and libv4l, provide common image formats regardless of the v4l device.
		v4l-utils
	];

	# MPV plugins.
	nixpkgs.overlays = with pkgs; [
		(self: super: {
			mpv = super.mpv.override {
				scripts = [
					## MPRIS plugin for mpv.
					self.mpvScripts.mpris

					## Script for mpv to skip sponsored segments of YouTube videos.
					self.mpvScripts.sponsorblock
				];
			};
		})
	];

}
