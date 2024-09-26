# Used NixOS packages:
#─────────────────────
# • [gimp]
#   https://www.gimp.org/
#
# • [krita]
#   https://krita.org/
#
# • [krita-plugin-gmic]
#   https://github.com/amyspark/gmic
#
# • [inkscape]
#   https://www.inkscape.org/
#
# • [pixelorama]
#   https://orama-interactive.itch.io/pixelorama
#
# • [imagemagick]
#   http://www.imagemagick.org/
#
# • [libjxl]
#   https://github.com/libjxl/libjxl
#
# • [dcmtk]
#   https://dicom.offis.de/dcmtk
#
# • [libwebp]
#   https://developers.google.com/speed/webp/
#
# • [hyprpicker]
#   https://github.com/hyprwm/hyprpicker
#
# • [gcolor3]
#   https://gitlab.gnome.org/World/gcolor3
#
# • [hyprshot]
#   https://github.com/Gustash/hyprshot
#
# • [oxipng]
#   https://github.com/shssoichiro/oxipng
#
# • [jpegoptim]
#   https://www.kokkonen.net/tjko/projects.html
#
# • [upscayl]
#   https://upscayl.github.io/
#
# • [lximage-qt]
#   https://github.com/lxqt/lximage-qt

{ pkgs, ... }: { environment.systemPackages = [

	# Image editing.
	## The GNU Image Manipulation Program (with plugins).
	pkgs.gimp-with-plugins

	## A free and open source painting application and GMic plugin for Krita.
	pkgs.krita pkgs.krita-plugin-gmic

	## Vector graphics editor (with extensions).
	pkgs.inkscape-with-extensions

	## Free & open-source 2D sprite editor, made with the Godot Engine.
	pkgs.unstable.pixelorama

	## A software suite to create, edit, compose, or convert bitmap images.
	pkgs.imagemagick

	# Image formats support.
	## JPEG XL image format reference implementation.
	pkgs.libjxl

	## Collection of libraries and applications implementing large parts of the DICOM standard.
	pkgs.dcmtk

	## Tools and library for the WebP image format.
	pkgs.libwebp

	# Color pickers.
	## A wlroots-compatible Wayland color picker that does not suck.
	pkgs.unstable.hyprpicker

	## A simple color chooser written in GTK3.
	pkgs.gcolor3

	# Image utilities.
	## Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
	pkgs.unstable.hyprshot

	## Multithreaded lossless PNG compression optimizer.
	pkgs.oxipng

	## Optimize JPEG files.
	pkgs.jpegoptim

	## Free and Open Source AI Image Upscaler.
	pkgs.upscayl

	# Image viewers.
	pkgs.unstable.lxqt.lximage-qt

]; }
