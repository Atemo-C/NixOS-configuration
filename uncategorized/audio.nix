{ config, lib, ... }: lib.mkMerge [
	{ services.pipewire = {
		enable = true;

		alsa = {
			enable = true;
			support32Bit = true;
		};

		jack.enable = true;
		pulse.enable = true;
	}; }

	(lib.mkIf config.services.pipewire.enable {
		services.playerctld.enable = true;
		security.rtkit.enable = true;

		programs = {
			alsa-utils.enable = true;
			audacious.enable = true;
			audacity.enable = true;
			easytag.enable = true;
			pwvucontrol.enable = true;
			qpwgraph.enable = true;
			soundfont.fluid.enable = true;

			fish.shellAbbrs = (
				let
					mpv-ytb = ''mpv --quiet --no-video "https://www.youtube.com/watch?v='';

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

					abbrs = builtins.listToAttrs (
						map (stream: {
							name = stream.name;
							value = ''${mpv-ytb}${stream.id}"'';
						}) streams
					);
				in abbrs
			);
		};
	}; )
]