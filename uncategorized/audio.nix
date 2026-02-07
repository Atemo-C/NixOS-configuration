{ config, lib, pkgs, ... }: {
	services = {
		# Whether to enable the PipeWire multimedia framework.
		# Support for emulation of other audio servers available.
		pipewire.enable = true;
		pipewire.alsa.enable = true;
		pipewire.alsa.support32Bit = true;
		pipewire.jack.enable = true;
		pipewire.pulse.enable = true;

		# Whether to enable the playerctld daemon for easy multimedia control.
		playerctld.enable = lib.mkIf config.services.pipewire.enable true;
	};

	# Whether to enable the Realtimekit service.
	# This allows programs like PipeWire to acquire realtime priority.
	security.rtkit.enable = true;

	programs = lib.mkIf config.services.pipewire.enable {
		# Various utilities for ALSA.
		alsa-utils.install = true;

		# Lightweight and versatile audio player.
		audacious.enable = true;

		# Sound editor with graphical UI.
		audacity.install = true;

		# View and edit tags for various audio files
		easytag.install = true;

		# PipeWire volume control.
		pwvucontrol.install = true;

		# QT graph manager for PipeWire, similar to QjackCtl.
		qpwgraph.install = true;

		soundfont = {
			# Frank Wen's pro-quality GM/GS soundfont. (MIT)
			arachno.enable = false;

			# General MIDI-compliant bank. (Unfree)
			fluid.enable = true;

			# Acoustic grand piano. (CC 3.0)
			generaluser.enable = false;

			# 259 instruments presets and 11 drum kits. (GS 2.0)
			ydp-grand.enable = false;
		};

		# Shell abbreviations for listening to various online audio streams with MPV.
		fish.shellAbbrs = (
			let
				# Base MPV command.
				mpv-ytb = ''mpv --quiet --no-video "https://www.youtube.com/watch?v='';

				# List of audio streams.
				streams = [
					{ name = "lofi-asian";      id = "Na0w3Mz46GA"; }
					{ name = "lofi-escape";     id = "S_MOd40zlYU"; }
					{ name = "lofi-guitar";     id = "E_XmwjgRLz8"; }
					{ name = "lofi-jazz";       id = "HuFYqnbVbzY"; }
					{ name = "lofi-medieval";   id = "IxPANmjPaek"; }
					{ name = "lofi-piano";      id = "TtkFsfOP9QI"; }
					{ name = "lofi-pomodoro";   id = "1oDrJba2PSs"; }
					{ name = "lofi-pov";        id = "uFlzUaisbig"; }
					{ name = "lofi-purr";       id = "xORCbIptqcc"; }
					{ name = "lofi-rain";       id = "-OekvEFm1lo"; }
					{ name = "lofi-sad";        id = "P6Segk8cr-c"; }
					{ name = "lofi-sleep";      id = "28KRPhVzCus"; }
					{ name = "lofi-study";      id = "jfKfPfyJRdk"; }
					{ name = "lofi-summer";     id = "SXySxLgCV-8"; }
					{ name = "lofi-synthwave";  id = "4xDzrJKXOOY"; }
					{ name = "nightinthewoods"; id = "AsLKfqA73uE"; }
					{ name = "tunic";           id = "gzWd5hjcaPo"; }
				];

				# Generate the full abbreviations.
				abbrs = builtins.listToAttrs (
					map (stream: {
						name = stream.name;
						value = ''${mpv-ytb}${stream.id}"'';
					}) streams
				);
			in abbrs
		);
	};
}