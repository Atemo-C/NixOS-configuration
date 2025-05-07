{ config, pkgs, ... }: let

	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in { environment.systemPackages = [
	# Extremely simplistic image viewing.
	pkgs.feh

	# The GNU Image Manipulation Program (with plugins).
	pkgs.gimp3-with-plugins

	# Lightweight and flexible command-line JSON processor (here for screenshots).
	pkgs.jq

	# A free and open source painting application and GMic plugin for Krita.
	pkgs.krita pkgs.krita-plugin-gmic

	# A software suite to create, edit, compose, or convert bitmap images.
	pkgs.imagemagick

	# Vector graphics editor
	pkgs.inkscape

	# JPEG XL image format reference implementation.
	pkgs.libjxl

	# Collection of libraries and applications implementing large parts of the DICOM standard.
	pkgs.dcmtk

	# Tools and library for the WebP image format.
	pkgs.libwebp

	# A simple color chooser written in GTK3.
	pkgs.gcolor3

	# Multithreaded lossless PNG compression optimizer.
	pkgs.oxipng

	# Optimize JPEG files.
	pkgs.jpegoptim

	# Free and Open Source AI Image Upscaler.
	pkgs.upscayl

	# Image viewers.
	pkgs.lxqt.lximage-qt

] ++ (
	# Only install these packages if Hyprland is enabled.
	if hyprland then [
		# Take screenshots with grimblast.
		pkgs.grimblast

		# Pick a color on the monitor with Hyprpicker.
		pkgs.hyprpicker
	] else []

); }
