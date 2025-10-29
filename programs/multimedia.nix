{ config, lib, pkgs, ... }: let
	# Shortcuts to check if various programs are installed.
	# All but `parallel` can be found here; `parallel` can be found in the `./programs/shell-utilities.nix` module.
	ffm = lib.elem pkgs.ffmpeg-full config.environment.systemPackages;
	gal = lib.elem pkgs.gallery-dl  config.environment.systemPackages;
	jpg = lib.elem pkgs.jpegoptim   config.environment.systemPackages;
	jxl = lib.elem pkgs.libjxl      config.environment.systemPackages;
	par = lib.elem pkgs.parallel    config.environment.systemPackages;
	png = lib.elem pkgs.oxipng      config.environment.systemPackages;
	ytd = config.home-manager.users.${config.userName}.programs.yt-dlp.enable;
in {
	# Video4Linux2 kernel module.
	#boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
	#boot.initrd.kernelModules = [ "v4l2loopback" ];

	environment.systemPackages = with pkgs; [
		#v4l-utils   # V4L utilities and libv4l, providing common image formats regardless of the v4l device.
		ffmpeg-full # A complete solution to record, convert, stream audio and video.
		gallery-dl  # Dowload image galleries
		libde265    # Open h.265 video codec implementation.
		dcmtk       # Collection of libraries and applications implementing large parts of the DICOM standard.
		imagemagick # Software suite to create, edit, compose, and convert bitmap images.
		oxipng      # PNG optimiser.
		jpegoptim   # JPEG optimiser.
		libjxl      # JPEL XL image format reference implementation.
		libwebp     # Tools and library for the WebP image format.

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

		# General-purpose media player; Fork of MPlayer and mplayer2.
		# Includes some plugins.
		(pkgs.mpv.override { scripts = with pkgs.mpvScripts; [
			mpris
			sponsorblock
		]; } )
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		gcolor3              # Color picker.
		gimp3                # The GNU Image Manipulation Program.
		inkscape             # Vector graphics editor.
		kdePackages.kdenlive # Video editor based on the MLT and KDE Frameworks.
		krita                # Painting and animation program.
		lxqt.lximage-qt      # Image viewer.
		#upscayl              # AI image upscaler.
	]);

	home-manager.users.${config.userName} = {
		# Whether to enable yt-dlp, a CLI tool to download videos from YouTube and other websites; Fork of yt-dl.
		programs.yt-dlp.enable = true;

		# Link the configuration files for yt-dlp and mpv.
		systemd.user.tmpfiles.rules = [
			"L %h/.config/mpv/mpv.conf - - - - /etc/nixos/programs/files/mpv.conf"
		] ++ lib.optional ytd
			"L %h/.config/yt-dlp/config - - - - /etc/nixos/programs/files/yt-dlp.conf";
	};

	programs.obs-studio = lib.mkIf config.programs.niri.enable {
		# Whether to enable OBS.
		enable = true;

		# NVIDIA hardware acceleration.
		package = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) (
			pkgs.obs-studio.override { cudaSupport = true; }
		);

		# OBS plugins to install.
		plugins = with pkgs.obs-studio-plugins; [
			obs-gstreamer              # Source, encoder and video filter plugin to use GStreamer elements/pipelines.
			obs-pipewire-audio-capture # Audio device and application capture for OBS Studio using PipeWire
			obs-vaapi                  # VAAPI support via GStreamer.
			obs-vkcapture              # Linux Vulkan/OpenGL game capture.
		];
	};

	# Shell abbreviations for various programs installed in this module.
	programs.fish.shellAbbrs = lib.mkIf config.programs.fish.enable {
		# Losslessly optimize all JPEG and PNG images in the current directory.
		# The original files are overridden.
		opti-jpg = lib.mkIf jpg "jpegoptim -s -v *.jp{,e}g";
		opti-png = lib.mkIf png "oxipng --strip all -v *.png";

		# Losslessly convert all JPEG and PNG images to JPEG XL ones in the current directory.
		# The original files are kept.
		jpg-jxl = lib.mkIf (jxl && par) "parallel cjxl -e 9 '{}' '{.}'.jxl -v ::: *.jp{,e}g";
		png-jxl = lib.mkIf (jxl && par) "parallel cjxl -e 9 '{}' '{.}'.jxl -d 0 -v ::: *.png";

		# Convert `.jxl` images to `.png` ones in the current directory.
		# The original files are kept.
		jxl-png = lib.mkIf (jxl && par) "parallel djxl '{}' '{.}'.png -v ::: *.jxl";

		# Batch download images normally and through a Tor proxy.
		imgdl     = lib.mkIf gal "gallery-dl";
		imgdl-tor = lib.mkIf gal "gallery-dl --proxy socks5://localhost:9050";

		# Simple yt-dlp shortcut normally and through a Tor proxy.
		yt     = lib.mkIf ytd "yt-dlp -t sleep";
		yt-tor = lib.mkIf ytd "yt-dlp -t sleep --proxy socks5://localhost:9050";

		# Highest-quality MP3 audio-only download normally and through a Tor proxy.
		ytmp3     = lib.mkIf ytd "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0";
		ytmp3-tor = lib.mkIf ytd "yt-dlp -t sleep -x --audio-format mp3 --audio-quality 0 --proxy socks5://localhost:9050";

		# Hide the banner when using FFmpeg.
		ffmpeg = lib.mkIf ffm "ffmpeg -hide_banner";

		# Download videos from websites like X/Twitter directly with FFmpeg.
		ffx = lib.mkIf ffm ''ffmpeg -hide_banner -i "https://url-here.m3u8" -c copy -bsf:a aac_adtstoasc name.mp4'';
	};
}