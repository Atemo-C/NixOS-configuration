{ config, lib, pkgs, ... }: let
	obsPkg =
		if config.hardware.activeGpu == "nvidia-proprietary" then pkgs.obs-studio.override { cudaSupport = true; }
		else pkgs.obs-studio;
in {
	# Video4Linux2 Kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = with pkgs; [
		# Collection of libraries and applications implementing large parts of the DICOM standard.
		dcmtk

		# Audio effects for PipeWire applications.
		easyeffects

		# Tool to read, write, and edit EXIF meta information.
		exiftool

		# Complete, cross-platform solution to record, convert and stream audio and video.
		ffmpeg-full

		# Command-line program to download image-galleries and collections from several image hosting sites.
		gallery-dl

		# Simple color picker written in GTK3.
		gcolor3

		# Command-line tool for creating, editing, and getting information about GIF images and animations.
		gifsicle

		# GIF encoder based on libimagequant (pngquant).
		gifski

		# GNU Image Manipulation Program.
		gimp

		# Software suite to create, edit, compose, or convert bitmap images.
		imagemagick

		# Vector graphics editor.
		inkscape

		# Optimize JPEG files.
		jpegoptim

		# Free and open source video editor, based on MLT and KDE Frameworks.
		kdePackages.kdenlive

		# Free and open source painting application.
		krita

		# Open h.265 video codec implementation.
		libde265

		# JPEG XL image format reference implementation.
		libjxl

		# Tools and library for the WebP image format.
		libwebp

		# General-purpose media player, fork of MPlayer and mplayer2.
		(mpv.override {scripts = with pkgs.mpvScripts; [
			# MPRIS plugin for mpv.
			mpris

			# Script for mpv to skip sponsored segments of YouTube videos.
			sponsorblock
		]; })

		# Minimal CLI to control OBS Studio via obs-websocket.
		obs-cmd

		# Generic image viewer from Linux Mint.
		pix

		# Multithreaded lossles PNG compressor optimizer.
		oxipng

		# Feature-rich command-line audio/video downloader.
		yt-dlp

		# V4L utils and libv4l, providing common image formats regardless of the v4l device.
		v4l-utils

		# Open source multimedia framework, and accompanying plugins.
		gst_all_1.gstreamer
		gst_all_1.gst-editing-services
		gst_all_1.gst-libav
		gst_all_1.gst-plugins-bad
		gst_all_1.gst-plugins-base
		gst_all_1.gst-plugins-good
		gst_all_1.gst-plugins-rs
		gst_all_1.gst-plugins-ugly
		gst_all_1.gst-vaapi
	];

	programs = {
		obs-studio = {
			# Whether to enable OBS for video recording and live streaming.
			enable = true;

			# OBS package to use.
			package = obsPkg;

			# OBS plugins to install.
			plugins = with pkgs.obs-studio-plugins; [
				# OBS Studio source, encoder, and video filter plugin to use GStreamer elements/pipelines.
				obs-gstreamer

				# Audio device and application capture using PipeWire.
				obs-pipewire-audio-capture

				# VAAPI support via GStreamer.
				obs-vaapi

				# Vulkan/OpenGL game capture.
				obs-vkcapture
			];
		};

		fish.shellAbbrs = {
			# JPEG image optimization (replaces existing files).
			opti-jpg = "${pkgs.jpegoptim}/bin/jpegoptim -s *.jp{,e}g";
			opti-jpg-recursive = "${pkgs.jpegoptim}/bin/jpegoptim -s **/*.jp{,e}g";

			# PNG image optimization (replaces existing files).
			opti-png = "${pkgs.oxipng}/bin/oxipng --strip all --opt 5 *.png";
			opti-png-recursive = "${pkgs.oxipng}/bin/oxipng --strip all --opt 5 **/*.png";

			# PNG image optimization, without touching APNG files (replaces existing files).
			opti-png-a = "${pkgs.oxipng}/bin/oxipng -s --opt 5 *.png";
			opti-png-a-recursive = "${pkgs.oxipng}/bin/oxipng -s --opt 5 **/*.png";

			# GIF image optimization (replaces existing files).
			opti-gif = "${pkgs.gifsicle}/bin/gifsicle -b -O5 *.gif";
			opti-gif-recursive = "${pkgs.gifsicle}/bin/gifsicle -b 05 **/*.gif";

			# Downlad multimedia files from various online sources.
			imgdl = "${pkgs.gallery-dl}/bin/gallery-dl -D ./";
			imgdl-tor = "${pkgs.gallery-dl}/bin/gallery-dl --proxy socks5://localhost:9050 -D ./";

			# Download videos from various online sources.
			yt = "${pkgs.yt-dlp}/bin/yt-dlp -t sleep";
			yt-tor = "${pkgs.yt-dlp}/bin/yt-dlp -t sleep --proxy socks5://localhost:9050";

			# Download audio from various online sources.
			ytmp3 = "${pkgs.yt-dlp}/bin/yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0";
			ytmp3-tor = "${pkgs.yt-dlp}/bin/yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0 --proxy socks5://localhost:9050";

			# Hide the default banner when using ffmpeg.
			ffmpeg = "${pkgs.ffmpeg-full}/bin/ffmpeg -hide_banner";
		};
	};

	# Link MPV and yt-dlp's configuration files to the user's home directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.concatLists [
		(lib.optional (lib.any (pkg: lib.hasPrefix "mpv" pkg.name) config.environment.systemPackages)
		"L %h/.config/mpv/mpv.conf - - - - /etc/nixos/programs/files/mpv.conf")

		(lib.optional (lib.elem pkgs.yt-dlp config.environment.systemPackages)
		"L %h/.config/yt-dlp/config - - - - /etc/nixos/programs/files/yt-dlp.conf")
	];
}