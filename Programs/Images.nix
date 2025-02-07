{ pkgs, ... }: { environment.systemPackages = [

	# Extremely simplistic image viewing.
	pkgs.feh

	# Take screenshots with grim and slurp.
	pkgs.grim pkgs.slurp

	# The GNU Image Manipulation Program (with plugins).
	pkgs.gimp-with-plugins

	# Lightweight and flexible command-line JSON processor (here for screenshots).
	pkgs.jq

	# A free and open source painting application and GMic plugin for Krita.
	pkgs.krita pkgs.krita-plugin-gmic

	# Vector graphics editor (with extensions).
	pkgs.inkscape-with-extensions

	# Free & open-source 2D sprite editor, made with the Godot Engine.
	pkgs.unstable.pixelorama

	# A software suite to create, edit, compose, or convert bitmap images.
	pkgs.imagemagick

	# JPEG XL image format reference implementation.
	pkgs.libjxl

	# Collection of libraries and applications implementing large parts of the DICOM standard.
	pkgs.dcmtk

	# Tools and library for the WebP image format.
	pkgs.libwebp

	# A wlroots-compatible Wayland color picker that does not suck.
	pkgs.unstable.hyprpicker

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

]; }
