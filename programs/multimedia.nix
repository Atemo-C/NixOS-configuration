{ config, lib, pkgs, ... }: let
	# Shortcuts to check if various programs are installed.
	# All but `parallel` can be found in this module.
	# `parallel` can be found in the `./programs/shell-utilities.nix` module.
	ffm = lib.elem pkgs.ffmpeg-full config.environment.systemPackages;
	gal = lib.elem pkgs.gallery-dl  config.environment.systemPackages;
	jpg = lib.elem pkgs.jpegoptim   config.environment.systemPackages;
	jxl = lib.elem pkgs.libjxl      config.environment.systemPackages;
	par = lib.elem pkgs.parallel    config.environment.systemPackages;
	png = lib.elem pkgs.oxipng      config.environment.systemPackages;
	ytd = config.home-manager.users.${config.userName}.programs.yt-dlp.enable;
in {

	# Video4Linux2 Kernel module.
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	environment.systemPackages = with pkgs; [
		# V4L utilities and libv4l, providing common image formats regardless of the v4l device.
		v4l-utils

		# Open-source multimedia framework.
		gst_all_1.gst-editing-services
		gst_all_1.gst-libav
		gst_all_1.gst-plugins-bad
		gst_all_1.gst-plugins-base
		gst_all_1.gst-plugins-good
		gst_all_1.gst-plugins-rs
		gst_all_1.gst-plugins-ugly
		gst_all_1.gst-vaapi
		gst_all_1.gstreamer

		# A complete solution to record, convert, stream audio and video.
		ffmpeg-full

		# Open h.265 video codec implementation.
		libde265

		# General-purpose media player; Fork of MPlayer and mplayer2.
		# Includes some plugins.
		(pkgs.mpv.override { scripts = with pkgs.mpvScripts; [
			mpris
			sponsorblock
		]; } )

		# Collection of libraries and applications implementing large parts of the DICOM standard.
		dcmtk

		# Software suite to create, edit, compose, and convert bitmap images.
		imagemagick

		# PNG optimiser.
		oxipng

		# JPEG optimiser.
		jpegoptim

		# JPEL XL image format reference implementation.
		libjxl

		# Tools and library for the WebP image format.
		libwebp
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		# Color picker.
		gcolor3

		# The GNU Image Manipulation Program.
		gimp3

		# Vector graphics editor.
		inkscape

		# Video editor based on the MLT and KDE Frameworks.
		kdePackages.kdenlive

		# Painting and animation program.
		krita

		# Image viewer.
		lxqt.lximage-qt

		# AI image upscaler.
		upscayl
	]);

	home-manager.users.${config.userName} = rec {
		# Whether to enable yt-dlp, a CLI tool to download videos from YouTube and other websites; Fork of yt-dl.
		programs.yt-dlp.enable = true;

		# Link the configuration files for yt-dlp and mpv to the right place.
		systemd.user.tmpfiles.rules = [
			"L %h/.config/mpv/mpv.conf - - - - /etc/nixos/programs/files/mpv.conf"
		] ++ lib.optional ytd
			"L %h/.config/yt-dlp/config - - - - /etc/nixos/programs/files/yt-dlp.conf";
	};

	# Shell abbreviations for various programs installed in this module.
	programs.fish.shellAbbrs = lib.mkIf config.programs.fish.enable {
		# Losslessly optimize all JPEG images in the current directory.
		# The original files are overridden.
		opti-jpg = lib.mkIf jpg "jpegoptim -s -v *.jp{,e}g";

		# Losslessly optimize all PNG images in the current directory.
		# The original files are overriden.
		opti-png = lib.mkIf png "oxipng --strip all -v *.png";

		# Losslessly convert all JPEG images to JPEG XL ones in the current directory.
		# The original files are kept.
		jpg-jxl = lib.mkIf (jxl && par) "parallel cjxl -e 9 '{}' '{.}'.jxl -v ::: *.jp{,e}g";

		# Losslessly convert all PNG images to JPEG XL ones in the current directory.
		# The original files are kept.
		png-jxl = lib.mkIf (jxl && par) "parallel cjxl -e 9 '{}' '{.}'.jxl -d 0 -v ::: *.png";

		# Convert `.jxl` images back to `.png` ones in the current directory.
		# The original files are kept.
		jxl-png = lib.mkIf (jxl && par) "parallel djxl '{}' '{.}'.png -v ::: *.jxl";

		# Batch download images.
		imgdl = lib.mkIf gal "gallery-dl";

		# Same as above, but through a Tor proxy (`tor --client socks5`).
		imgdl-tor = lib.mkIf gal "gallery-dl --proxy socks5://localhost:9050";

		# Simple yt-dlp shortcut.
		yt = lib.mkIf ytd "yt-dlp -t sleep";

		# Highest-quality MP3 audio-only download.
		ytmp3 = lib.mkIf ytd "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0";

		# Same two shortcuts as above, but through a Tor proxy (`tor --client socks5`).
		yt-tor    = lib.mkIf ytd "yt-dlp -t sleep --proxy socks5://localhost:9050";
		ytmp3-tor = lib.mkIf ytd "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0 --proxy socks5://localhost:9050";

		# Hide the banner when using FFmpeg.
		ffmpeg = lib.mkIf ffm "ffmpeg -hide_banner";

		# Download videos from websites like X/Twitter directly with FFmpeg.
		ffx = lib.mkIf ffm ''ffmpeg -hide_banner -i "https://url-here.m3u8" -c copy -bsf:a aac_adtstoasc name.mp4'';

		# Listen to various online audio streams with MPV.
		lofi-asian      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=Na0w3Mz46GA"'';
		lofi-escape     = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=S_MOd40zlYU"'';
		lofi-jazz       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=HuFYqnbVbzY"'';
		lofi-medieval   = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=IxPANmjPaek"'';
		lofi-piano      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=TtkFsfOP9QI"'';
		lofi-pomodoro   = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=1oDrJba2PSs"'';
		lofi-pov        = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=uFlzUaisbig"'';
		lofi-purr       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=xORCbIptqcc"'';
		lofi-rain       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=-OekvEFm1lo"'';
		lofi-sad        = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=P6Segk8cr-c"'';
		lofi-sleep      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=28KRPhVzCus"'';
		lofi-stduy      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'';
		lofi-summer     = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=SXySxLgCV-8"'';
		lofi-synthwave  = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=4xDzrJKXOOY"'';
		nightinthewoods = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=AsLKfqA73uE"'';
		tunic           = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=gzWd5hjcaPo"'';
	};
}