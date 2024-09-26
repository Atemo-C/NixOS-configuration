# Used NixOS packages:
#─────────────────────
# • [audacious]
#   https://audacious-media-player.org/
#
# • [easytag]
#   https://gitlab.gnome.org/GNOME/easytag
#
# • [playerctl]
#   https://github.com/acrisci/playerctl
#
# • [audacity]
#   https://www.audacityteam.org/
#
# • [alsa-utils]
#   http://www.alsa-project.org/
#
# • [easyeffects]
#   https://github.com/wwmm/easyeffects
#
# • [pavucontrol]
#   http://freedesktop.org/software/pulseaudio/pavucontrol/
#
# • [qpwgraph]
#   https://gitlab.freedesktop.org/rncbc/qpwgraph

{ pkgs, ... }: { environment.systemPackages = [

	## Music.
	# A lightweight and versatile audio player.
	pkgs.audacious

	# View and edit tags for various audio files.
	pkgs.easytag

	# Command-line utility and library for controlling media players that implement MPRIS.
	pkgs.playerctl

	# Sound editing.
	## Sound editor with graphical UI.
	pkgs.audacity

	# Audio utilities.
	## Utilities for ALSA, the Advanced Linux Sound Architecture utils.
	pkgs.alsa-utils

	## Audio effects for PipeWire applications.
	pkgs.unstable.easyeffects

	## PulseAudio and PipeWire Volume Control.
	pkgs.unstable.pavucontrol

	## Qt graph manager for PipeWire, similar to QjackCtl..
	pkgs.unstable.qpwgraph

]; }
