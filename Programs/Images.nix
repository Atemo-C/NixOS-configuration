{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# Extremely simplistic image viewing.
	feh

	# Take screenshots with grimblast.
	grimblast

	# The GNU Image Manipulation Program (with plugins).
	gimp-with-plugins

	# Lightweight and flexible command-line JSON processor (here for screenshots).
	jq

	# A free and open source painting application and GMic plugin for Krita.
	krita krita-plugin-gmic

	# A software suite to create, edit, compose, or convert bitmap images.
	imagemagick

	# JPEG XL image format reference implementation.
	libjxl

	# Collection of libraries and applications implementing large parts of the DICOM standard.
	dcmtk

	# Tools and library for the WebP image format.
	libwebp

	# A wlroots-compatible Wayland color picker that does not suck.
	hyprpicker

	# A simple color chooser written in GTK3.
	gcolor3

	# Multithreaded lossless PNG compression optimizer.
	oxipng

	# Optimize JPEG files.
	jpegoptim

	# Free and Open Source AI Image Upscaler.
	upscayl

	# Image viewers.
	lxqt.lximage-qt

]; }
