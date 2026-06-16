{ config,lib, pkgs, ... }: lib.mkIf config.services.pipewire.enable {
	# Whether to enable the playerctld daemon for media control.
	services.playerctld.enable = true;

	# Whether to enable the RealtimeKit system service,
	# handing out realtime scheduling priority to user processes on demand.
	# For example, PipeWire uses this to acquire realtime priority.
	security.rtkit.enable = true;

	environment = {
		systemPackages = with pkgs; [
			# Utilities for ALSA.
			alsa-utils

			# Audio player.
			audacious

			# Sound editor.
			audacity

			# Music tag editor.
			eartag

			# Volume and sound control.
			pwvucontrol

			# Graph manager for PipeWire, similar to QjackCtl.
			qpwgraph

			# Frank Wen's pro-quality GM/GS soundfont.
			soundfont-fluid
		];

		# Make MIDI soundfonts accessible in `/run/current-system/sw/share/`.
		pathsToLink = [ "/share/soundfonts" ];
	};

	# Shell abbreviations to play online radios.
	programs.fish.shellAbbrs = (
		let mpv-ytb = ''mpv --no-video "https://www.youtube.com/watch?v='';

		streams = [
			{ name = "lofi-synthwave";  id = "4xDzrJKXOOY"; }
			{ name = "lofi-escape";     id = "S_MOd40zlYU"; }
			{ name = "lofi-rain";       id = "-OekvEFm1lo"; }
			{ name = "lofi-medieval";   id = "IxPANmjPaek"; }
			{ name = "lofi-deepsleep";  id = "xORCbIptqcc"; }
			{ name = "lofi-guitar";     id = "E_XmwjgRLz8"; }
			{ name = "lofi-fireplace";  id = "q_4KI-ChIIs"; }
			{ name = "lofi-halloween";  id = "3GQY80jyysQ"; }
			{ name = "lofi-calmjazz";   id = "A8jDx9TLMQc"; }
			{ name = "lofi-classical";  id = "jXAEIWcGXwE"; }
			{ name = "lofi-christmas";  id = "XSXEaikz0Bc"; }
			{ name = "lofi-piano";      id = "N0snMcR6aaA"; }
			{ name = "lofi-sleep";      id = "JD-kMIpDfnY"; }
			{ name = "lofi-jazz";       id = "E2vONfzoyRI"; }
			{ name = "lofi-asian";      id = "1Tl2FtV06qo"; }
			{ name = "lofi-sad";        id = "CwPCy1GLS38"; }
			{ name = "lofi-pomodoro";   id = "qGohtGC5Rtk"; }
			{ name = "lofi-synthsleep"; id = "GSfT7H87zq4"; }
			{ name = "lofi-study";      id = "X4VbdwhkE10"; }
		];

		abbrs = builtins.listToAttrs (
			map (stream: {
				name = stream.name;
				value = ''${mpv-ytb}${stream.id}"'';
			}) streams
		);

		in abbrs
	);
}