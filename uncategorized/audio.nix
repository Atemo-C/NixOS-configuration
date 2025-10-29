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
		playerctld.enable = true;

		# Whether to enable live audio effects using EasyEffects.
		easyeffects.enable = lib.mkIf config.services.pipewire.enable true;
	};

	# Whether to enable the Realtimekit service.
	# This allows programs like PipeWire to acquire realtime priority.
	security.rtkit.enable = true;

	programs = lib.mkIf config.services.pipewire.enable {
		# Various utilities for ALSA.
		alsa-utils.enable = true;

		# Lightweight and versatile audio player.
		audacious.enable = true;

		# View and edit tags for various audio files
		easytag.enable = true;

		# PipeWire volume control.
		pwvucontrol.enable = true;

		# QT graph manager for PipeWire, similar to QjackCtl.
		qpwgraph.enable = true;

		audacity = {
			# Whether to enable Audacity, a sound editor with graphical UI.
			enable = true;

			# Which Audacity package to install.
			package = pkgs.tenacity;
		};

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
		fish.shellAbbrs = lib.mkIf config.programs.fish.enable {
			lofi-asian      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=Na0w3Mz46GA"'';
			lofi-escape     = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=S_MOd40zlYU"'';
			lofi-guitar     = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=E_XmwjgRLz8"'';
			lofi-jazz       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=HuFYqnbVbzY"'';
			lofi-medieval   = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=IxPANmjPaek"'';
			lofi-piano      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=TtkFsfOP9QI"'';
			lofi-pomodoro   = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=1oDrJba2PSs"'';
			lofi-pov        = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=uFlzUaisbig"'';
			lofi-purr       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=xORCbIptqcc"'';
			lofi-rain       = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=-OekvEFm1lo"'';
			lofi-sad        = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=P6Segk8cr-c"'';
			lofi-sleep      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=28KRPhVzCus"'';
			lofi-study      = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'';
			lofi-summer     = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=SXySxLgCV-8"'';
			lofi-synthwave  = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=4xDzrJKXOOY"'';
			nightinthewoods = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=AsLKfqA73uE"'';
			tunic           = ''mpv --quiet --no-video "https://www.youtube.com/watch?v=gzWd5hjcaPo"'';
		};
	};
}