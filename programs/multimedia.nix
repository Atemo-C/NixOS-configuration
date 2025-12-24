{ config, lib, pkgs, ... }: {
	# Video4Linux2 kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	programs = rec {
		# Collection of libraries and applications implementing large parts of the DICOM standard.
		dcmtk.enable = true;

		# Download image galleries.
		gallery-dl.enable = true;

		# Color picker.
		gcolor3.enable = true;

		# The GNU Image Manipulation Program.
		gimp.enable = true;

		# Software suite to create, edit, compose, and convert bitmap images.
		imagemagick.enable = true;

		# Vector graphics editor.
		inkscape.enable = true;

		# JPEG optimiser.
		jpegoptim.enable = true;

		# Video editor based on the MLT and KDE Frameworks.
		kdenlive.enable = true;

		# Painting and animation program.
		krita.enable = true;

		# Open h.265 video codec implementation.
		libde265.enable = true;

		# JPEG XL image format reference implementation.
		libjxl.enable = true;

		# Tools and librarry for the WebP image format.
		libwebp.enable = true;

		# Image viewer.
		lxqt.lximage-qt.enable = true;

		# PNG optimizer.
		oxipng.enable = true;

		# CLI tool to download videos from YouTube and other websites; Fork of yt-dl.
		yt-dlp.enable = true;

		# V4L utilities and lib4vl, providing common image formats regardless of the v4l device.
		v4l-utils.enable = true;

		ffmpeg = {
			# Whether to install FFmpeg, complete solution to record, convert, stream audio and video.
			enable = true;

			# Which FFmpeg package to install.
			package = pkgs.ffmpeg-full;
		};

		gstreamer = {
			# Whether to install GStreamer, an open-source multimedia framework.
			enable = true;

			# Which GStreamer plugins to install.
			plugins = with pkgs.gst_all_1; [
				gst-editing-services
				gst-libav
				gst-plugins-bad
				gst-plugins-base
				gst-plugins-good
				gst-plugins-rs
				gst-plugins-ugly
				gst-vaapi
			];
		};

		mpv = {
			# Whether to install MPV, a general-purpose media player; Fork of MPlayer and mplayer2.
			enable = true;

			# MPV plugins to install.
			plugins = with pkgs.mpvScripts; [
				mpris
				sponsorblock
			];
		};

		obs-studio = {
			# Whether to install OBS, free and open-source software for video recording and live streaming.
			enable = true;

			# Whether to compile OBS with CUDA support.
			# This would make NixOS rebuilds take a LONG time when OBS has to be built,
			# however, the CUDA binary cache is enabled, and it *should* solve this issue.
			cudaSupport = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) true;

			# OBS plugins to install.
			plugins = with pkgs.obs-studio-plugins; [
				# Source, encoder and video filter plugin to use GStreamer elements/pipelines.
				obs-gstreamer

				# Audio device and application capture for OBS Studio using PipeWire.
				obs-pipewire-audio-capture

				# VAAPI support via GStreamer.
				obs-vaapi

				# Linux Vulkan/OpenGL game capture.
				obs-vkcapture
			];
		};

		# Shell abbreviations for various programs installed in this module.
		fish.shellAbbrs = {
			# Losslessly optimize all JPEG images in the current directory.
			# The original files are overridden.
			opti-jpg = lib.mkIf jpegoptim.enable "jpegoptim -s -v *.jp{,e}g";

			# Losslessly optimize all PNG images in the current directory.
			# The original files are overridden.
			opti-png = lib.mkIf oxipng.enable "oxipng --strip all -v *.png";

			# Losslessly convert all JPEG images to JPEG XL ones in the current directory.
			# The original files are kept.
			jpg-jxl = lib.mkIf (
				libjxl.enable
				&& config.programs.parallel.enable
			) "parallel cjxl -e 8 '{}' '{.}'.jxl -v ::: *.jp{,e}g";

			# Losslessly convert all PNG images to JPEG XL ones in the current directory.
			# The original files are kept.
			png-jxl = lib.mkIf (
				libjxl.enable
				&& config.programs.parallel.enable
			) "parallel cjxl -e 8 '{}' '{.}'.jxl -d 0 -v ::: *.png";

			# Losslessly convert JPEG XL images to PNG ones in the current directory.
			# The original files are kept.
			jxl-png = lib.mkIf (
				libjxl.enable
				&& config.programs.parallel.enable
			) "parallel djxl '{}' '{.}'.png -v ::: *.jxl";

			# Losslessly convert JPEG XL images to JPEG ones in the current directory.
			jxl-jpg = lib.mkIf (
				libjxl.enable
				&& config.programs.parallel.enable
			) "parallel djxl '{}' '{.}'.jpg -v ::: *.jxl";

			# Batch download images normally and through a Tor proxy.
			imgdl = lib.mkIf gallery-dl.enable "gallery-dl";
			imgdl-tor = lib.mkIf gallery-dl.enable "gallery-dl --proxy socks5://localhost:9050";

			# Download videos normally and through a Tor proxy.
			yt = lib.mkIf yt-dlp.enable "yt-dlp -t sleep";
			yt-tor = lib.mkIf yt-dlp.enable "yt-dlp -t sleep --proxy socks5://localhost:9050";

			# Dowlond audio normally and through a Tor proxy.
			ytmp3 = lib.mkIf yt-dlp.enable "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0";
			ytmp3-tor = lib.mkIf yt-dlp.enable "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0 --proxy socks5://localhost:9050";

			# Hide the banner when using FFmpeg.
			ffmpeg = lib.mkIf ffmpeg.enable "ffmpeg -hide_banner";

			# Download videos from websites like X/Twitter directly with FFMpeg.
			ffx = lib.mkIf ffmpeg.enable ''ffmpeg -hide_banner -i "https://url-here.m3u8" -c copy -bsf:a aac_adtstoasc name.mp4'';
		};
	};

	systemd.user.tmpfiles.users.${config.userName}.rules = []
	++ lib.optional config.programs.mpv.enable "L %h/.config/mpv/mpv.conf - - - - /etc/nixos/programs/files/mpv.conf"
	++ lib.optional config.programs.yt-dlp.enable "L %h/.config/yt-dlp/config - - - - /etc/nixos/programs/files/yt-dlp.conf";
}